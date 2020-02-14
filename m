Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63A715E94D
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 18:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392276AbgBNRGK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 12:06:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44335 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392462AbgBNRGJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 12:06:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so11468039ljj.11;
        Fri, 14 Feb 2020 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U+GOvbpQG5UqF/JyIXafr2HFQH54O+9fIORiMKWoN9w=;
        b=YMESWuIsUJerFKvWLzO+dCkm5MiLYBbLAcFgQcIzq9b/M/3DRpgTeBbsCDYMZw1MTg
         GWb1eUmS46moMBwNnYSrJcKmCMlo4IIrLg/LUME9UiZ5R2p8sc3tgmCXb9qdJKbQgkLG
         IM4FA/eDiQ7A7yVB8bJugbDZ63nU0R63pcsUBIlOBz8je5ruhWRObh3krpKpnU92OI7J
         K8+IauQXTno4qt0rtDp/urYROl2hi89kZiHU/HPrk+SDFfg+FNyKSp3KIg73mCYBEmBj
         0DkI1N/bfwyAhjW5W8cV4bXWDDEYt83qN0Mu+fMZrkdxgkn8WU1EfMa2GEaBQYm4a1Wn
         0Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U+GOvbpQG5UqF/JyIXafr2HFQH54O+9fIORiMKWoN9w=;
        b=SzSn2LesVV+w2lSTMgaZp044DA+pVWmmch05ekiH7wHeYNIGU9oPu7twwG/arbisZG
         V6d7BlX3zNJfepurrcPHV1k0ZhXktltA9L0Qvc1d09+oDd8H0pgxJFInu0zgSOl1KqFM
         +8NPklkOEW8s5TvYh19ZURl42bDoh4Zj3v27Ds8pF3wXEwffFS/uHtEpX9GRntGf8l3L
         +oQkjYUPE7/T/t2/q3KzVEXMXRlhPv6BPwYvk8YuhkxGy7x6G4QeFKQhHSfjvl0/gUOt
         65Z1fi598w+HLg2LZLR0VheCyWnQN8gWioeQOsbacp5S9RQ6XVBCOWPcmhv+l+JUm/Hi
         Ud4A==
X-Gm-Message-State: APjAAAUQw8mdpW7NFT7lPFfw3EvbhDHfK1kar/wJa91Ldpqzc0QzrAQ4
        xstEGuEW9p1sK4YqwTDIbAk=
X-Google-Smtp-Source: APXvYqzjC8iNkYfJyuOtvpZsAh//9ILGI/ZxOKZbpipy8WkGWX6GW6NcDhuwKtP4Mxt4VBxDPawlRQ==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr2704208ljh.42.1581699967362;
        Fri, 14 Feb 2020 09:06:07 -0800 (PST)
Received: from localhost.localdomain.localdomain ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id p12sm3217470lfc.43.2020.02.14.09.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 09:06:06 -0800 (PST)
From:   Li Xinhai <lixinhai.lxh@gmail.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org
Subject: [PATCH manpage] mbind.2: remove note about MPOL_MF_STRICT been ignored
Date:   Fri, 14 Feb 2020 17:03:58 +0000
Message-Id: <1581699838-7483-1-git-send-email-lixinhai.lxh@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Current code ignores the MPOL_MF_STRICT when handling hugetlb mapping,
now patch([1]) handles MPOL_MF_STRICT in same semantic as other mapping.
So, we can remove the note about 'MPOL_MF_STRICT is ignored on huge page
mappings', and no changes to other part of man-page.

[1] https://lore.kernel.org/linux-mm/1581559627-6206-1-git-send-email-lixinhai.lxh@gmail.com/

Signed-off-by: Li Xinhai <lixinhai.lxh@gmail.com>
---
 man2/mbind.2 | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/man2/mbind.2 b/man2/mbind.2
index 16644ff..8c07270 100644
--- a/man2/mbind.2
+++ b/man2/mbind.2
@@ -471,9 +471,6 @@ Support for huge page policy was added with 2.6.16.
 For interleave policy to be effective on huge page mappings the
 policied memory needs to be tens of megabytes or larger.
 .PP
-.B MPOL_MF_STRICT
-is ignored on huge page mappings.
-.PP
 .B MPOL_MF_MOVE
 and
 .B MPOL_MF_MOVE_ALL
-- 
1.8.3.1

