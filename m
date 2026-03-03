Return-Path: <linux-api+bounces-5897-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOyyIeYrp2mIfgAAu9opvQ
	(envelope-from <linux-api+bounces-5897-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 03 Mar 2026 19:43:50 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E45381F569B
	for <lists+linux-api@lfdr.de>; Tue, 03 Mar 2026 19:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41F9F30156DD
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2026 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3073348883;
	Tue,  3 Mar 2026 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln0RcmFl"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D396276041
	for <linux-api@vger.kernel.org>; Tue,  3 Mar 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563424; cv=none; b=Xu/fAdvd+XD7/NGHtqktvFDt13J/k4gpZyXsj0bnTn/SEap4v6wX0z9njXrwzo7VzvYcHNHedS5Ixrm2R6HXqn9D14RlPEfjJ6ucxj7dg/BQuqpN+uzTI1KqUiGnYaMdJKknPWT4Fk3E6fz78Q0Tyu1pc3qta1/qbL6AkrZMqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563424; c=relaxed/simple;
	bh=qDvE2HJEzyMcQRpPVVWxoIOiiyNAJs6RPSw659rPKdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBKUWxhw0kXjmfExTEl48X1BwOIq8WjPVyVIt8HTbZ/ebeFrPtdAOoOBqrhKd6ie4WfECwKrLKNWI8T3i0OgpHznn259jqappcVRFxb/DS/UGd7LH7AEht2OPk36AYFAfffvYYISDqY767lPBpF6tgW90g7u1MyUJWjtcpI2kz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln0RcmFl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso51465095e9.3
        for <linux-api@vger.kernel.org>; Tue, 03 Mar 2026 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772563422; x=1773168222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX8r5kTeexA5hjBkPMWcoH7tf0SLIu7YLl43ZFEMlvc=;
        b=ln0RcmFlqg8xmAq8QVHCExDdtxLGmej1nQ/XA1rN2L4H5xD7P2204wOEqASZbpIwYx
         7T31BHhhhI7pkx6tXZoYMUecKICB3HZ4gAekCMG4Jo2YX6TO+ieWb3ODknjDtW476mE+
         mYFrzZ/lbCi63g5fwuoQ1Mc/4T5P8UIMmffSu8iiyzmrnkGgxWWxuQ/XgVV192mGYc6j
         l1Nj8OCMuDQb1il8SCsFaW79kVEK0PdVFwkjUKHJCOnElt+WyGRg28tlfxwtCyl2Z+iw
         mJ9q8pKwxnH3oOc4Su2mXoR9j686PPTfmWrJVPeDPZydPa/AujL2J9LPKsCTvj+PhtnC
         rJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563422; x=1773168222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WX8r5kTeexA5hjBkPMWcoH7tf0SLIu7YLl43ZFEMlvc=;
        b=sQOuecNoaAGRxWtFbe36FpkHp3deUi5sifn7Cz84rP1VuXwOKq78nKs8XeamknnJVc
         XZkPvXZURBTgPNcKPOaSwaTWwW+m32oepFLL9NkL2XYyFa9Jgp/ATfIcaUqV4K3WB0nW
         qBAVhqjXt3WEIuI/ahX8rCPUjB6IkM7QNN+O+B1PTsAijwj2zpzV9NNiOz0SpD22mL2Y
         2VkqEiLxcCzXkwCAR9YTM7bxY+nnBB9rFqw0hbBbrB8Ce/U7FO9+Utu33BQYayLb+zYW
         ZeJIFsxBdjcd2jsKoNmp3oOBJ05BBx04/31HUDEXqK99C5S0tZUrbB3D5Ifm6+aHYLCP
         mCqA==
X-Forwarded-Encrypted: i=1; AJvYcCUExSBj1Oc4Mp+TdtelCvfl9JgYupOVNqSHsgtnxxmqxdgrDzaPCf5CXorsgXuq0jJG/hDIlQGLB7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkFn0S4/l9oQqPHl9OUMYgccXACvPvuWk0qOQpSb2wQfy9AFj
	jcjhtPifKlhfnQ4xcDDD3bN+Frlqcec/Z58hzlTKkbsZnV4+rq/B0NU2
X-Gm-Gg: ATEYQzyR/iPPTPrPrsfcS0VA4e4XkAz0RUx5SyZo5zbpLaOOuMFDH4VAM+YHh4hEHpI
	wMM8dN4jNKwJDYDs9gewGAlBHcHH/ceVEWhOiEyx/JVlNDoGk294vCAyUDg6vTxuKinFs1JABkJ
	OmWm/ySRxwe9tnDaVDSnaP5PT6qBOhRsywwhkEaRlPg1l2+cLZS5Qp/QC81kpHjCskYd2qnjBaW
	s6zuZSB4dCS3Xv9SfEl7WgX/7MxJacd/QlSuHCQoNW4cjIEbIaN1k2fIQ1n05k11+TOmKecIzTh
	1UMNGt++MRD7/e571bRuIAcEc01+HxoTBm+93Es3BxazwAf7Jw1cfgErZOpT/oz6FjBdf3IwJjZ
	8KhoEg2KnT28lnkU3l1C9jqWnLoZEB54pq7tKbkZ/1VsnKmhqPI49J9rKrhYn9d3Ok9DF3uWVIi
	ml2iWIm1pxJ7q621nYxOQgJ0aypnp1/+Sf1qhtITlTBNzDQXnTbrJVIC5RaFBfSBUl6jqY3fw1W
	y6x8LvUbB/yCmp0BR5Rx4LL923ghyygDPUa
X-Received: by 2002:a05:600c:699a:b0:471:700:f281 with SMTP id 5b1f17b1804b1-483c9bf44e8mr275137185e9.25.1772563421171;
        Tue, 03 Mar 2026 10:43:41 -0800 (PST)
Received: from laptom.homenet.telecomitalia.it (host-87-6-205-41.retail.telecomitalia.it. [87.6.205.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm444134115e9.6.2026.03.03.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:43:40 -0800 (PST)
From: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
X-Google-Original-From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	linux-api@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: document new sched_getattr() feature for retrieving current parameters for DEADLINE tasks
Date: Tue,  3 Mar 2026 19:42:48 +0100
Message-ID: <20260303184313.1356499-1-tommaso.cucinotta@santannapisa.it>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260303104215.1324243-1-tommaso.cucinotta@santannapisa.it>
References: <20260303104215.1324243-1-tommaso.cucinotta@santannapisa.it>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E45381F569B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5897-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommasocucinotta@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[santannapisa.it:mid,santannapisa.it:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Document in Documentation/sched/sched-deadline.rst the new capability of
sched_getattr() to retrieve, for DEADLINE tasks, the runtime left and absolute
deadline (setting the flags syscall parameter to 1), in addition to the static
parameters (obtained with flags=0).

Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
---
 Documentation/scheduler/sched-deadline.rst | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index ec543a12..76fdf435 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -628,10 +628,21 @@ Deadline Task Scheduling
   * the new scheduling related syscalls that manipulate it, i.e.,
     sched_setattr() and sched_getattr() are implemented.
 
- For debugging purposes, the leftover runtime and absolute deadline of a
- SCHED_DEADLINE task can be retrieved through /proc/<pid>/sched (entries
- dl.runtime and dl.deadline, both values in ns). A programmatic way to
- retrieve these values from production code is under discussion.
+ The leftover runtime and absolute deadline of a SCHED_DEADLINE task can be
+ read using the sched_getattr() syscall, setting the last syscall parameter
+ flags to the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 value. This updates the
+ runtime left, converts the absolute deadline in CLOCK_MONOTONIC reference,
+ then returns these parameters to user-space. The absolute deadline is
+ returned as the number of nanoseconds since the CLOCK_MONOTONIC time
+ reference (boot instant), as a u64 in the sched_deadline field of sched_attr,
+ which can represent nearly 585 years since boot time (calling sched_getattr()
+ with flags=0 causes retrieval of the static parameters instead).
+
+ For debugging purposes, these parameters can also be retrieved through
+ /proc/<pid>/sched (entries dl.runtime and dl.deadline, both values in ns),
+ but: this is highly inefficient; the returned runtime left is not updated as
+ done by sched_getattr(); the deadline is provided in kernel rq_clock time
+ reference, that is not directly usable from user-space.
 
 
 4.3 Default behavior

base-commit: f74d204baf9febf96237af6c1d7eff57fba7de36
-- 
2.45.2


