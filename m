Return-Path: <linux-api+bounces-5293-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEDC60D45
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1CF34E21FF
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE3328C854;
	Sat, 15 Nov 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DJ/Bocdf"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607C273D9A
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249683; cv=none; b=uGadZegLY9LMUqKVSFarTP6aVQezocA9gzQfe+FGzOY0one3ezZVhcJKFUyEfIUr0qyZ8s3ONyqJsI+Yd3I1LFa55Edphs9CKdJDHMzyUq01G1lhuBEuvOCS7y4eAlty493rSRbb94t1iyi6jnaI7ghrDb4c7yzpYokLopmfcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249683; c=relaxed/simple;
	bh=BcQ/q/HLfjUC/A/ryQjCYpP7otXrO8RSxRHDXnqgx54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjrh9PJMiXjQ7+4BE/3NU/VhaOId+GH9q6ibmGbW6vsZc+ud7Ccz5CioUtauzM9BtqeQ04nFHLy4mv+7KptpB85mUXbeyfOmd4uEuaH3U2vaAnhHNzzsv2Hm6GfpFq7mOJUYI/8Y/tDbQ0Ze+rx4yFb4eAgjgtfgQBfYArd/faE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DJ/Bocdf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7866aca9ff4so31462537b3.3
        for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 15:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249679; x=1763854479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMpZqjn+eetCXAXNQY+bjgKy9hWait8fsWMBfgLawx8=;
        b=DJ/BocdfPWOR4Bxk7q936aHJKqMhTobW1Pm8UA46plJ0JXAJyLM1vn+tri2NewiTgN
         FEsiCkJNq5hB+1e1+ARINqp6E5rNq2nNGb2OlWWEUJc7c6TtLz63MEw5kV0bTrsK7akj
         RskPchmn5z/wk9O8o7LdX62v+GA5DF3aNGsmeuKxCUgYUNXeA6a5sO4s+qjb9nPs6PLE
         dpt7yllYlT4mMYFRco89JhXp2Raz+CyWEoeASCdxuXIZzguneWTiFKl82du9uvjOLauL
         Wa27hHoPt5X7yXg6GA9ix/zVcaDDEfyiNKVdOdnAlA6g5vYrm3+ej609WTgQkQO/RDJh
         kZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249679; x=1763854479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eMpZqjn+eetCXAXNQY+bjgKy9hWait8fsWMBfgLawx8=;
        b=LQINXrNwx9oKhY6z8ts40bepJqcNSkpT4CGRm4L6/ro+LfW7xPrqRSEyYCawveWU8g
         SyW+f+TQEr1+yMnNtDppUe3AR4QUslG0KXDuY+W8S/hz+QCth2mUFkgTEidigbwG3Pcw
         Z35K9cDd2sF1aFFZW8PqKg8y3wEHe5j3wvhrHGPQiodwiaHLKupTKEMh4kIm/ivYxPqC
         szdsQvGxmNYlJ361Q+4BXA27NVbea/0jMoD13H/YL36MRs8XBhAxhLqnDzfmuNQ6bxdl
         7y8w9ktnquqQmhoY3DkBRmmj62VzzFieApLx/09zAnnhijiRvEozdSKH8f0zfPu2PDsa
         vDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8wvpHI94NLtIDuQqvk+tBq1PisXVwMwyUHM3rwCRvy9QZXMd25UNEzeY5Xw7x2Tw+PnojtCq0vDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+zCvONiUwY1qw9CSepxSvkqYNJBG3wy3V6A77s6ZXKFzMbLi
	2qJlz8R5Yt2g74dCZLWwdTRY7lWeQCtTNJK9QVy/v4oH8eongUFQ7vjuL2W+5lAgr+Q=
X-Gm-Gg: ASbGncuKUupG7qJ3fpxAo3siZQOC5GBwdwjuJE4tX/56GzjjKYBt4poAAJOVhawn7VS
	d2/QukVafABicetRrB1JFhlWV0XOsnxYlkmhfAq17HNoVSrQEhQgGFtpK/PESc7tzPwdUSBkPW1
	rmbez71dS7qDBm8W76RZeoSqWyLODrFy4zJ0QcM5/1R3zdnwZ7rpwvkwl5NsAQdPkG9Py1GK7pZ
	mIvvC7ZhPOQ+jgrNCjXjHf3D8Vl/m1aoItkfUMhN/0bkk+mR4v1ZLnKRasTmBOAM675zkzrSUbk
	46aTEntdu9O7u58Cw26DFSnDtWcfnudK1tpZT4SoqlEIV4913an3uhJxTo3mJALyGe3e19XeuzV
	A8IvspiAhdZluZJ820Yx/JFJlGb1xqTbU0I7O+gl570uUxwCnMVdYxiJzTph88UzfSODDpdaRy+
	QAYuCOE+326MqILffI5/AXyloehicEfVPPifAKPZvgT+YGydEsmxxkcWdMljo0+1yywzcY
X-Google-Smtp-Source: AGHT+IFpvmU4rwVaUle/Xd4qMbKiIN+TYBpeyYU/cujp1isseucHsBaZ4L2SnGIl5nDP3gsBZTrPxA==
X-Received: by 2002:a05:690c:64c4:b0:788:1cde:cabb with SMTP id 00721157ae682-78929e2fd13mr69921557b3.20.1763249679369;
        Sat, 15 Nov 2025 15:34:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:39 -0800 (PST)
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
Subject: [PATCH v6 10/20] MAINTAINERS: add liveupdate entry
Date: Sat, 15 Nov 2025 18:33:56 -0500
Message-ID: <20251115233409.768044-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 500789529359..bc9f5c6f0e80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14464,6 +14464,17 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/linux/liveupdate/
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.52.0.rc1.455.g30608eb744-goog


