Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645098CBAF
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 08:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfHNGMu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Aug 2019 02:12:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56742 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfHNGMu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Aug 2019 02:12:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190814061247euoutp01bac6d779ee96df54653265e8088829e8~6tU4xc35j1566515665euoutp01X
        for <linux-api@vger.kernel.org>; Wed, 14 Aug 2019 06:12:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190814061247euoutp01bac6d779ee96df54653265e8088829e8~6tU4xc35j1566515665euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565763167;
        bh=zH0H/Am6rFEX7Tq6/Cx8jitdW00s+oXxcueR2OogNUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptEpUAIaNgvE1i5zMWM3q2N7x5ytt0Wtv8g9Y2t/LTULSrS0f/2k1Y1MSYnlvEFlM
         Y8yIUjA6BtVFyz/8fSkC5phA+CgSRWzlomq3M+3FjKpMGx6XZ4pm79et6aHw48PWk1
         igh8OVS+SSlOr8r1oZy2vLHKLriAeMoYvGNxSmps=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190814061247eucas1p273e1ee2d5ddfd66456a2e5b56a5cf0f7~6tU4AjTkD0131201312eucas1p22;
        Wed, 14 Aug 2019 06:12:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.EC.04469.E56A35D5; Wed, 14
        Aug 2019 07:12:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190814061246eucas1p128cae99a14f27bc79fa2aa72084a0413~6tU3HJw2A1469514695eucas1p1a;
        Wed, 14 Aug 2019 06:12:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190814061245eusmtrp2a1aaa016b1a42773ea640a87ed942faa~6tU23iRIY3153431534eusmtrp2L;
        Wed, 14 Aug 2019 06:12:45 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-af-5d53a65ef895
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.70.04166.D56A35D5; Wed, 14
        Aug 2019 07:12:45 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190814061245eusmtip1d471fa5f1d7b228d17d85b301acb80cd~6tU2VXBym2287722877eusmtip1W;
        Wed, 14 Aug 2019 06:12:45 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Subject: [PATCH] tracefs: Fix NULL pointer dereference when no lockdown is
 used
Date:   Wed, 14 Aug 2019 08:12:37 +0200
Message-Id: <20190814061237.17406-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3028ed35-3b6d-459f-f3c8-103c5636fe95@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzned24ZcGxBm8mGlhsnLGe1WLd+sVM
        FufPb2C32Py9g83i8q45bBYfeh6xWaw9cpfd4tULLYt/G96wWOzreMDkwOXRsu8Wu8eCTaUe
        m1Z1snn0fE/26NuyitHj8ya5ALYoLpuU1JzMstQifbsErow9D26zFMznqLjzp5upgfErWxcj
        B4eEgIlE93rnLkYuDiGBFYwS//Z/YYFwvjBKPLv7iBXC+cwo0b67j72LkROs40nnVEaIxHJG
        iQ9r/rLDtXxu+ccGUsUmYCjR9bYLzBYRUJDY3PsMbBSzwEcmiYuHP4AlhAUCJbb/OM4CYrMI
        qEpMuH8RzOYVsJVY276NDWKdvMTqDQeYQWxOAXuJA1ebwA6UEGhnl/i9ZgIzRJGLxJlDn6Bs
        YYlXx7dA3Soj8X/nfCaIhmZGiYfn1rJDOD2MEpebZjBCVFlLHD5+kRUUHswCmhLrd+lDhB0l
        Xh9YyQIJJj6JG28FQcLMQOakbdOZIcK8Eh1tQhDVahKzjq+DW3vwwiWoczwkph87ygwJoUmM
        Es1HGpkmMMrPQli2gJFxFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAqOf3v+KcdjF8v
        JR1iFOBgVOLhDdgSFCvEmlhWXJl7iFGCg1lJhHfCRaAQb0piZVVqUX58UWlOavEhRmkOFiVx
        3mqGB9FCAumJJanZqakFqUUwWSYOTqkGxgpGpa+bI/Yq3P+womy1iHLPCYPQ0/7/112c6psd
        tcf/RITI1uOCiyNa/0YH3xU4dHnKzneNC6zjt3Hsf6fK9DffwYl75dH8zmK3yXazdmhsuJOz
        Lr5j9YHk1XMU27Y2+Bs4N/5+eHzpNYXca4Z/+W79tirYHCmxK1C03seew8h475uaf81OJ5VY
        ijMSDbWYi4oTAQejCnohAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xu7qxy4JjDQ5OMrTYOGM9q8W69YuZ
        LM6f38Busfl7B5vF5V1z2Cw+9Dxis1h75C67xasXWhb/NrxhsdjX8YDJgcujZd8tdo8Fm0o9
        Nq3qZPPo+Z7s0bdlFaPH501yAWxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehl7HtxmKZjPUXHnTzdTA+NXti5GTg4JAROJJ51TGbsYuTiEBJYy
        Sryc94wRIiEjcXJaAyuELSzx51oXG0TRJ0aJb/P2gXWzCRhKdL3tArNFBBQkNvc+YwUpYhb4
        ziRxbtNfZpCEsIC/ROfrp2BTWQRUJSbcv8gCYvMK2Eqsbd8GdYa8xOoNB8DqOQXsJQ5cbQKq
        4QDaZifx4Lb3BEa+BYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLDetuxn5t3MF7aGHyI
        UYCDUYmHN2BLUKwQa2JZcWXuIUYJDmYlEd4JF4FCvCmJlVWpRfnxRaU5qcWHGE2BbprILCWa
        nA+MubySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxBAs0ma+5N
        ld1UcSeqUDKx87DxxZOfZ0z8eayz539w/44Dj/LVIh+IivFeYzl2lclLOsa8Y8YTgdfJDHZT
        5syb3yvC9CUoVmCX8AwF+7T2D5drCzvXvNz1jqF7fktyCrf4xHrNxm0t17Kc+RjqPtXxKu/r
        Nlmyqy1f+LYUw4q5CelG29hFFymxFGckGmoxFxUnAgAZkavBgQIAAA==
X-CMS-MailID: 20190814061246eucas1p128cae99a14f27bc79fa2aa72084a0413
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190814061246eucas1p128cae99a14f27bc79fa2aa72084a0413
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190814061246eucas1p128cae99a14f27bc79fa2aa72084a0413
References: <3028ed35-3b6d-459f-f3c8-103c5636fe95@samsung.com>
        <CGME20190814061246eucas1p128cae99a14f27bc79fa2aa72084a0413@eucas1p1.samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Commit 757ff7244358 ("tracefs: Restrict tracefs when the kernel is locked
down") added infrastructure for restricting tracefs access when lockdown
is enabled. It however broke tracefs operation when no lockdown is used.
Fix this issue by adding missing check for a NULL ->open() callback.

Fixes: 757ff7244358 ("tracefs: Restrict tracefs when the kernel is locked down")
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 12a325fb4cbd..8efff7603032 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -43,7 +43,7 @@ static int default_open_file(struct inode *inode, struct file *filp)
 		return ret;
 
 	real_fops = dentry->d_fsdata;
-	return real_fops->open(inode, filp);
+	return real_fops->open ? real_fops->open(inode, filp) : 0;
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
-- 
2.17.1

