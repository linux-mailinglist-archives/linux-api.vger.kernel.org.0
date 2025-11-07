Return-Path: <linux-api+bounces-5172-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345AC41BA8
	for <lists+linux-api@lfdr.de>; Fri, 07 Nov 2025 22:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63C204F7720
	for <lists+linux-api@lfdr.de>; Fri,  7 Nov 2025 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2272345CD6;
	Fri,  7 Nov 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dkaNzuWR"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912C3446CB
	for <linux-api@vger.kernel.org>; Fri,  7 Nov 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549566; cv=none; b=qjl7yriZfdpwrKlPozZyzXIHg8V4N19bzWvcpyO4g4hv3kB1cQ/y7A4+FNbV38MMNumR6cVtrY0KTd0MmYpQQi2NK9PSpELLCUMldNfRclDBhQI9QxtEhKvwXfsmJq3d2W4j06W6PsG9MwiPsTr9abv8OALTe/ae5xpNl9lweaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549566; c=relaxed/simple;
	bh=gBYU5h2sGDvuxmfL4Z2QJsnaixb4prWMGY/kIMgQSKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuDDL5b+iiLUCFpW6Tw2dLWjM999JECR5XjdIn2sBDcJN/pPh5+WJAoKebYvCvtApqa/BFSyrcC5qXkk0gFDXqCm6p2W/92e580DBIXt0I09+j6uBdjZvmPcWzea21hgM6VLzGWCy4cWeV9UOhva3i+u7ewiwhZpT4bxiID3iFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dkaNzuWR; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63e393c4a8aso1016013d50.2
        for <linux-api@vger.kernel.org>; Fri, 07 Nov 2025 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549563; x=1763154363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kO0F0lPOuqRuP1r+X7yx5ua65c5v8nyw+1ERu/tsRgQ=;
        b=dkaNzuWRbi2KA9O7G1cE8o4AlQpH8KyXcDKyriGVvGSJCChqK3r/tMNiz3wfnpqhGC
         86RV5evUXkXBgigC22waRO3uHc1gZ5xqxfv4G4Mh8XUSJgcD5hGR0GHzwv9UmkbVJjcl
         SBsyLpnZHmm/gp6jFd6QeKgPnUKgYTKirT1kNyzt9nS4mEGnI+6szZgJl1Y/54dKl0gO
         Sb/GAoPWrcIx/p94TaUGnLVYf+D6DgcEe/Eim2rtzeyaJCoWUzBx2BJUrk2OAkmU15Qc
         6p42DZWzG5Ls6mcMhIFNqc7BwPJNOWci+dQZOIKPUDlbWN5TjTnwytGvJE1wBnvzou3U
         bsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549563; x=1763154363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kO0F0lPOuqRuP1r+X7yx5ua65c5v8nyw+1ERu/tsRgQ=;
        b=sGbhbJLmcqJnRnEDnsHNQhETQfLJydILYcbVIJrAFp1CwBvArX9WIZMkRzZGCQvIpv
         oVynjCeA3dEMtsV/zJPfcR2yxFJ0U+A07b+Fdh5uLqkB69oqGgj3YqC/Bp9qQ0fJMLot
         gh/FE0UsHqLL4sMkFl77ASYbBtx2a+YgFZzZGqCTdzR+HuRPPNd5Tw4Y1PG+QEATY9Je
         QhjSkA88I4n0HIztAj8jW0bEERor2ByC9sZ3f2LESIAkhWThg4JTlhAzQFmHtv//rCqC
         XOlGaZ4C2HVjlNFb6ul2jKVSGIcOWBCYgCm3LpJti1HChiEkuCoBS1nNsj0OcVO0qRLN
         jhiw==
X-Forwarded-Encrypted: i=1; AJvYcCVmM7qoYb7/EvYFPBX1QlG56EgQzE8r3RDgR/NjU93O5twwB5aDTsAt/es14F16mZcWWy17n/BubN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWwj8n/SbYal8YBTPJlDxOemSHmki798UUM1waC2uNQM0b2T8
	lIjZCxIl56t8kH56BqhDnCcxHEahVmbby8dVmdcItD9F2/5w3hfVmMtZ6+US/BK6xEM=
X-Gm-Gg: ASbGncsB1E+3GYC2Hv2dCYv6A7cv5Ho/GxsFED0VdZluw3Kaa5Kf5bGvIoGs3lUDjmO
	oiYxsBHFOiNEie/ftAMjVf7VJeOPxQz0kpvyk4PPN4lcNCQvh3v63WEug0fv73ZK5RR/AM9d6Id
	5DecHj0dsMcq/pikcUtqXNFvzvWSzuksDmLLCZcCfQ/ZO6Isnaq4QWnr10wgwRH0vgx3MoQTIhy
	CAga4HBSyszC34jVi+2QQ/lkECCbm8aimlt5aSVtK/VET2ug1VFL1qB8D9ZjZqio0PxbCDOpEzl
	2njlAfox0+JFWN+vLki8oPkKmn6FyYtqmeX8w98mlHXbAAYkg5uv20AKyyFyx60lrvzKG9O1103
	u9li1mQGB5CgIaV9c1Sr7ySMnz80aXkmyhdyPzbFSFOpdq9/1GmPZXz90pe7/NL1Syno7liSOis
	U2TPn7g4eMf7Z6RHY0zYEKhyE69S0pay5Cm4QxNIUb6/eDtQe+1pjmvCaAupc7AwQ=
X-Google-Smtp-Source: AGHT+IGUrCGSnQ3TU6q4/qNhItgcbFdsWINOhF2gqc7ZvS0Ysq3WXcStnQvjg9cKvk8ErPoxGLBe8w==
X-Received: by 2002:a53:d005:0:b0:63e:10f1:28d9 with SMTP id 956f58d0204a3-640d45ce885mr343426d50.57.1762549563137;
        Fri, 07 Nov 2025 13:06:03 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:06:02 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 16/22] liveupdate: luo_file: add private argument to store runtime state
Date: Fri,  7 Nov 2025 16:03:14 -0500
Message-ID: <20251107210526.257742-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <pratyush@kernel.org>

Currently file handlers only get the serialized_data field to store
their state. This field has a pointer to the serialized state of the
file, and it becomes a part of LUO file's serialized state.

File handlers can also need some runtime state to track information that
shouldn't make it in the serialized data.

One such example is a vmalloc pointer. While kho_preserve_vmalloc()
preserves the memory backing a vmalloc allocation, it does not store the
original vmap pointer, since that has no use being passed to the next
kernel. The pointer is needed to free the memory in case the file is
unpreserved.

Provide a private field in struct luo_file and pass it to all the
callbacks. The field's can be set by preserve, and must be freed by
unpreserve.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h   | 5 +++++
 kernel/liveupdate/luo_file.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index ce39b77c89c3..3f55447d18ab 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -29,6 +29,10 @@ struct file;
  *                    this to the file being operated on.
  * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
  *                    this field.
+ * @private_data:     Private data for the file used to hold runtime state that
+ *                    is not preserved. Set by the handler's .preserve()
+ *                    callback, and must be freed in the handlers's
+ *                    .unpreserve() callback.
  *
  * This structure bundles all parameters for the file operation callbacks.
  * The 'data' and 'file' fields are used for both input and output.
@@ -39,6 +43,7 @@ struct liveupdate_file_op_args {
 	bool retrieved;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 };
 
 /**
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 7816c418a595..713069b96278 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -125,6 +125,10 @@ static LIST_HEAD(luo_file_handler_list);
  *                 This handle is passed back to the handler's .freeze(),
  *                 .retrieve(), and .finish() callbacks, allowing it to track
  *                 and update its serialized state across phases.
+ * @private_data:  Pointer to the private data for the file used to hold runtime
+ *                 state that is not preserved. Set by the handler's .preserve()
+ *                 callback, and must be freed in the handlers's .unpreserve()
+ *                 callback.
  * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
  *                 multiple retrieval attempts.
@@ -151,6 +155,7 @@ struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 	bool retrieved;
 	struct mutex mutex;
 	struct list_head list;
@@ -307,6 +312,7 @@ int luo_preserve_file(struct luo_session *session, u64 token, int fd)
 		goto exit_err;
 	} else {
 		luo_file->serialized_data = args.serialized_data;
+		luo_file->private_data = args.private_data;
 		list_add_tail(&luo_file->list, &session->files_list);
 		session->count++;
 	}
@@ -354,6 +360,7 @@ void luo_file_unpreserve_files(struct luo_session *session)
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
 
@@ -382,6 +389,7 @@ static int luo_file_freeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
@@ -403,6 +411,7 @@ static void luo_file_unfreeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
 	}
-- 
2.51.2.1041.gc1ab5b90ca-goog


