package com.ssafy.kkalong.domain.cloth.entity;

import com.ssafy.kkalong.domain.member.entity.Member;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
@Table(name = "tagRelation")
public class TagRelation {

    @Schema(description = "옷, 태그 일련번호")
    @EmbeddedId
    private TagRelationKey tagRelationKey;

    @Column(name = "is_tag_deleted ")
    @Schema(description = "삭제여부")
    private boolean isTagDeleted ;

    @Column(name = "tag_relation_del_date ")
    @Schema(description = "삭제일시")
    private LocalDateTime tagRelationDelDate ;

    @ManyToOne
    @JoinColumn(name = "cloth_seq ", referencedColumnName = "cloth_seq ", insertable = false, updatable = false)
    @Schema(description = "옷")
    private Member clothSeq ;

    @ManyToOne
    @JoinColumn(name = "tag_seq ", referencedColumnName = "tag_seq ", insertable = false, updatable = false)
    @Schema(description = "태그")
    private Member tagSeq ;


}
