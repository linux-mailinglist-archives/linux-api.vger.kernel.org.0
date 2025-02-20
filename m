Return-Path: <linux-api+bounces-3268-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C12A3E4FE
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2025 20:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943831774C0
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2025 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276D213E80;
	Thu, 20 Feb 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="XJUV1HHL"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF415A858;
	Thu, 20 Feb 2025 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079435; cv=none; b=lGFRqisdmft0vpWuLdzSsw2xm8pT26EfUEJjjO76q7lYKDxHsaeOKaHM1UBs9HHbd+elMcD0M36nVyUTXol5IlTqvhprA5I+eb5nX7OT17E+MvvNadXlt5sqFRpSxJ0oJRxjW4sAAdoXkl03K/wyjcFDtf/Wh5UiYH+z5qu45Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079435; c=relaxed/simple;
	bh=Kx3ZupbIX8xeCne7SCB3FZ/6eiMVlar2Wd0jfNp1a3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYI6pm2VjPRfz6MyYbhR79PEwEO1pYj7Q0vC9p8KxrtQB+Hkzg2r0jPzuW8iQh7ubT9pNUfawzLsHounYOV5eyVFwvYArpcmH8fsy2zQRGIcg2QM0PLu3J12EKwFGOOfTb44zdMVU1gcLn9MZIr71+GGerbltWigjBdekFlllKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=XJUV1HHL; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VTAamiveZ7VJKCdH6aCZIa8fM2hkXCdc+A0NTGbTtzc=; b=XJUV1HHLpi3ILn83GM9vOvANay
	pKI3SGRJto0q1Afrv49JpGbRMoyr+Cj2qP2Lj4tQJyOFs8hdhHLUEgE+1KpR0B4qQUKrkyBNAyKAr
	rAmW4DViRs7iQ81QfK1C4amukIOy2mn0uLk2yvIhVS5PBEmglKa6acb+JxBpznRjoHb2htmAbVOs3
	vDXU5RiVv8JMoxpHcrjxZppXxefq+R0/BlUpbjNYkfx64MRyrqD8EDD8nGmPp0i3VfIFdMQRzBTX+
	amqqDDF4ucMwjeEgsYwxqu2+hbo1swT+yB8CSn/h7q4MzEnxJ3bGVXDnPwFNbvqJigUZJYBw4ucht
	kreJAFqQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tlC9C-00HTKa-2l;
	Thu, 20 Feb 2025 13:23:46 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	Elizabeth Figura <zfigura@codeweavers.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] ntsync: Check wait count based on byte size.
Date: Thu, 20 Feb 2025 13:23:34 -0600
Message-ID: <20250220192334.549167-1-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC versions below 13 incorrectly detect the copy size as being static and too
small to fit in the "fds" array. Work around this by explicitly calculating the
size and returning EINVAL based on that, instead of based on the object count.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502072019.LYoCR9bF-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>

--

Suggested-by as per Arnd's request, but the only thing I changed was preserving
array_size() [as noted by Geert in the linked thread]. I tested and found no
regressions.

v2: Add missing sign-off

---
 drivers/misc/ntsync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 586b86243e1d..24cb2f71186a 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -873,6 +873,7 @@ static int setup_wait(struct ntsync_device *dev,
 {
 	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
 	const __u32 count = args->count;
+	size_t size = array_size(count, sizeof(fds[0]));
 	struct ntsync_q *q;
 	__u32 total_count;
 	__u32 i, j;
@@ -880,15 +881,14 @@ static int setup_wait(struct ntsync_device *dev,
 	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
 		return -EINVAL;
 
-	if (args->count > NTSYNC_MAX_WAIT_COUNT)
+	if (size >= sizeof(fds))
 		return -EINVAL;
 
 	total_count = count;
 	if (args->alert)
 		total_count++;
 
-	if (copy_from_user(fds, u64_to_user_ptr(args->objs),
-			   array_size(count, sizeof(*fds))))
+	if (copy_from_user(fds, u64_to_user_ptr(args->objs), size))
 		return -EFAULT;
 	if (args->alert)
 		fds[count] = args->alert;
-- 
2.47.2


