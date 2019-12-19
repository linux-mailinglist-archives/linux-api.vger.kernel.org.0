Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E472E125A6C
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2019 06:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfLSFNw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Dec 2019 00:13:52 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6125 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfLSFNw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Dec 2019 00:13:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfb06f20000>; Wed, 18 Dec 2019 21:13:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 21:13:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 18 Dec 2019 21:13:51 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Dec
 2019 05:13:51 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 19 Dec 2019 05:13:50 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dfb070e0001>; Wed, 18 Dec 2019 21:13:50 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
CC:     <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH] move_pages.2: remove ENOENT from the list of possible return values
Date:   Wed, 18 Dec 2019 21:13:47 -0800
Message-ID: <20191219051347.1278026-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576732402; bh=9R3otvYjxL+EhzYozx6MHy5SVGQPaMnj791NKARfzDo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=pBgP9BeT11sBQ7OaVQILvcGGl6CzWgDqvsaSTzwyqM78gphzm/5LVdioLZNllm+4H
         y6wt61DriVzx0s62ZtjPFf3KC+wFnjSh3kGMguMxUL1d44VBwbHUGgeCDBiP08YtpT
         b9t8ZDktVlUsUpS0KJzf41g9Rhcl/MkhwPlXemDu9Tv2PGPGBRomInr51RJD8ql1MA
         6gb07qWLhsSYuU88apCj3O/0T+Xk9aLsWBut91BSM5NUWvKdbrMCtGQco2elQ4RGJs
         ZKw+tcWS33OtldT6pfMjEhBw2L2PYBGGbGy5KD/qQL8/HGc21CNe0PcZRNvG4tpun8
         3Iscb9A7XifEA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Linux kernel commit e78bbfa82624 ("mm: stop returning -ENOENT from
sys_move_pages() if nothing got migrated") had the effect of *never*
returning -ENOENT, in any situation. So we need to update the man page
to reflect that ENOENT is not a possible return value.

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Christoph Lameter <cl@linux.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

This fix for the man page was ACK'd by Michal, here:

https://lore.kernel.org/r/20191218101711.GB21485@dhcp22.suse.cz

thanks,
John Hubbard
NVIDIA

 man2/move_pages.2 | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/man2/move_pages.2 b/man2/move_pages.2
index 2d96468fa..1bf1053f2 100644
--- a/man2/move_pages.2
+++ b/man2/move_pages.2
@@ -191,12 +191,6 @@ was specified or an attempt was made to migrate pages =
of a kernel thread.
 .B ENODEV
 One of the target nodes is not online.
 .TP
-.B ENOENT
-No pages were found that require moving.
-All pages are either already
-on the target node, not present, had an invalid address or could not be
-moved because they were mapped by multiple processes.
-.TP
 .B EPERM
 The caller specified
 .B MPOL_MF_MOVE_ALL
--=20
2.24.1

