Return-Path: <linux-api+bounces-4890-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86660B8D3B3
	for <lists+linux-api@lfdr.de>; Sun, 21 Sep 2025 04:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C196F7A4F63
	for <lists+linux-api@lfdr.de>; Sun, 21 Sep 2025 02:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A71F91C8;
	Sun, 21 Sep 2025 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhjV7ttH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB154791
	for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758422598; cv=none; b=corCTiAwDzUQ62y6OlmHJnjLnVoANkVp+XjZ/SbIq/N7/77VWIhhFuWf/s3c464SSbVhYhHjaZe62do28xYQTqM3hMLIm4lvhSCNlDgMK2hMWx7q9YHApeYayPJOI9WwicKrJWHm1b+xD1v1D57oJe3FpME6NCOx/dYybzdQBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758422598; c=relaxed/simple;
	bh=IOLNp7bbvWfurHuoNIdJ0OXo/N5Q2rG8Kwy2TSpxEww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiLbQt3FZ9A+6G3LygsMXS2cyu2yU0UuovLEJkTzflMopqqSGH8VJQciL8HSQ80X6LvtHOn4yc7WhpG3cC+SjRVmKIe0kQbveBLwaKGnDw/FdO5iWVRH2HKCQnUw4uyGPfiMWiawdSmqnFNiWSvruz+yF6+VpiBb6PjvIsoDWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhjV7ttH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so29062366b.0
        for <linux-api@vger.kernel.org>; Sat, 20 Sep 2025 19:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758422595; x=1759027395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuEJ7Kuw6nXBxfCflCZImXovS/FAgf8BObIoPTsH704=;
        b=fhjV7ttHOrlrbrtH01IvFX7CntG4DvBxipSKCbmNFeb1/wcuzEdqikiTbDNnHRKrQr
         nkEaMVH6M1jJ7nga/pW82uwiN7qAy0GJBMMM12DIPMmNjFXTlbGaB1gDy9ahuI68viWu
         nr5MAtJG516HckWQMgtqdOT2iJ7bwsU26y1HG41lMrtdJ44J0snLpW/2ehfPfiimpGAf
         hxnmP7OSoD57TWz9oaiMcV+vNTfZgPHM3PXaer3u2Oh8k/qGgzephwKWiCZ0lrdipz9R
         qgcJ306bkLKYp7nUyNTKBEj8FXvK4EE1Z+WGxpWC3pPjRi0vmo9pPAPbN9pY8un4J6/8
         kFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758422595; x=1759027395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuEJ7Kuw6nXBxfCflCZImXovS/FAgf8BObIoPTsH704=;
        b=S7digJdryzzYJcCc06+vXYrrocARvjNKn0A7lmGbSvWlzLY7r4hKccpV5g9LzrmPe9
         2EzRsV3RoKO4uFoSsb2sZ2nVYY85FuYuK9ZSsgAgrX5f2OoAmOgQKLF2HwlRC2qcF23D
         OiZ2am9Al1Wr4BojoSwgwWXlmrtOJeaJ4AaJ026Uj5Kn+07RrMAQPtQLsNp+vmSXsU2o
         SBa0Qecoh1jq0mtJ8xtYrfKT4T/dPHDywYvauOvDtFdlzb3m7XP/nQXbPKggAmaa6YBd
         voJbJ/OEXAbV7X55MmfHyhc+sDUq2Q22MxQt1jgdaVmUSMfD95NO5XGyAt4QPN3bl1sN
         JWkg==
X-Forwarded-Encrypted: i=1; AJvYcCVOkOlPwAnNvxWrD0NfRZ1R62a0Q6SfnOrW1okUqvn/95A1zY1Y+ZkhcPD2MSbEILCATRuQXYdBMjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz739O1zzRfZ2B80gPFqeGTvyKDFVFHHw5wqJHpeKF6zS84y+u+
	VGA/EChdLbEtJIgfCIRH2ohJcxP+X6Q3A7DRvxWFB5K+qEWGNIarrW33
X-Gm-Gg: ASbGncswzSX+q6vQa3rXsm/njRq3kdNTHGNoGsq2oytoAbUHn+/8Kl/U8xjqUrjV8yE
	9tG7ugC6Au4IumgrgbdesumiKoG9n8eNT0guMNZDkx+mLqRsfvrJL7vkWwooauHH2cNrT7/biER
	EhqSF2orlDT+CQE6HPROOziPVA0SaOYnXDrZuXaofTjFVEkZzmA5xsNPjDdxxv57Oe1OHaRSrNw
	h2gc9vdl7+FnPGJQf9vlxvmT2Y6bCE7lSaUi24xxPYn5rTpKTPH0Rj6qwuwlZeWUca0EJwnE2qy
	Pt3ms7oyoDX4DV9GpjU/DcGxe2ZMBTWPInrKWsOoTSTITlchy8fHDpEH19bpWlg7J0vI5H5PPbm
	PXvkpzgMo36ySOtXgkZU=
X-Google-Smtp-Source: AGHT+IEnp3bNDrsmT04jwsuiPJbBPOdlnvUNGeBA+GfxOGwI+dq26By1MGxiqYL9UlRIJoqPtfeHuA==
X-Received: by 2002:a17:907:96a4:b0:b04:830f:822d with SMTP id a640c23a62f3a-b24f568a6cdmr856877566b.63.1758422595233;
        Sat, 20 Sep 2025 19:43:15 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b28be3fa38bsm224619366b.46.2025.09.20.19.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 19:43:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 00/10] man2: document "new" mount API
Date: Sun, 21 Sep 2025 05:43:10 +0300
Message-ID: <20250921024310.80511-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aleksa, thank you! Don't give up. We all need these manpages.

I see you didn't address some my previous notes.

* move_mount(2) still says "Mount objects cannot be attached beneath the filesystem root".
I suggest saying "root directory" or "root" or "root directory of the process" or just "/"
instead. But you may keep this phrase as is, of course.

* Docs for FSPICK_NO_AUTOMOUNT in fspick(2) are still wrong. They say that FSPICK_NO_AUTOMOUNT
affects all components of path. Similar thing applies to mount_setattr(2) and move_mount(2)

* open_tree(2) still says:
> If flags does not contain OPEN_TREE_CLONE, open_tree() returns a file descriptor
> that is exactly equivalent to one produced by openat(2) when called with the same dirfd and path.

This is not true if automounts are involved. I suggest adding "modulo automounts". But you may
keep everything, of course.

-- 
Askar Safin

