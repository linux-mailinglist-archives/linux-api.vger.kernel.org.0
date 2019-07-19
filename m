Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C392E6EA00
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2019 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfGSRVS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Jul 2019 13:21:18 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45995 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728446AbfGSRVS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Jul 2019 13:21:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TXIdl-p_1563556863;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TXIdl-p_1563556863)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Jul 2019 01:21:14 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [v4 PATCH 0/2] mm: mempolicy: fix mbind()'s inconsistent behavior for unmovable pages
Date:   Sat, 20 Jul 2019 01:21:00 +0800
Message-Id: <1563556862-54056-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Changelog
v4: * Fixed the comments from Vlastimil.
    * Collected Vlastimil's Reviewed-by.
v3: * Adopted the suggestions from Vlastimil.  Saved another 20 lines.
      Using flag in struct queue_pages looks not outperform renumbering retval
      too much since we still have to return 1 to tell the caller there are
      unmovable pages.  So just renumber the retval.
    * Manpage is not very clear about shared pages when MPOL_MF_MOVE is
      specified, just leave it as it is for now till it gets clarified.
v2: * Fixed the inconsistent behavior by not aborting !vma_migratable()
      immediately by a separate patch (patch 1/2), and this is also the
      preparation for patch 2/2. For the details please see the commit
      log.  Per Vlastimil.
    * Not abort immediately if unmovable page is met. This should handle
      non-LRU movable pages and temporary off-LRU pages more friendly.
      Per Vlastimil and Michal Hocko.


Yang Shi (2):
      mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
      mm: mempolicy: handle vma with unmovable pages mapped correctly in mbind

 mm/mempolicy.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 27 deletions(-)
