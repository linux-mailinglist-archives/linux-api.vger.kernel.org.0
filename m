Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798A7327B82
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhCAKFx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 05:05:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:35096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231847AbhCAKD6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 05:03:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2219AAC5;
        Mon,  1 Mar 2021 10:03:10 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-api@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] MAINTAINERS: exclude uapi directories in API/ABI section
Date:   Mon,  1 Mar 2021 11:02:55 +0100
Message-Id: <20210301100255.25229-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <CAKgNAkiVWvzQOwRGOdSoh8JY-DpxcF6pWdLWNK4RHFdN-d6=+w@mail.gmail.com>
References: <CAKgNAkiVWvzQOwRGOdSoh8JY-DpxcF6pWdLWNK4RHFdN-d6=+w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Commit 7b4693e644cb ("MAINTAINERS: add uapi directories to API/ABI section")
added include/uapi/ and arch/*/include/uapi/ so that patches modifying them
CC linux-api. However that was already done in the past and resulted in too
much noise and thus later removed, as explained in b14fd334ff3d ("MAINTAINERS:
trim the file triggers for ABI/API")

To prevent another round of addition and removal in the future, change the
entries to X: (explicit exclusion) for documentation purposes, although they
are not subdirectories of broader included directories, as there is apparently
no defined way to add plain comments in subsystem sections.

Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..591829cd1ba4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -261,8 +261,8 @@ ABI/API
 L:	linux-api@vger.kernel.org
 F:	include/linux/syscalls.h
 F:	kernel/sys_ni.c
-F:	include/uapi/
-F:	arch/*/include/uapi/
+X:	include/uapi/
+X:	arch/*/include/uapi/
 
 ABIT UGURU 1,2 HARDWARE MONITOR DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
-- 
2.30.1

