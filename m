Return-Path: <linux-api+bounces-3928-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01DEADCAA9
	for <lists+linux-api@lfdr.de>; Tue, 17 Jun 2025 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BC83A9922
	for <lists+linux-api@lfdr.de>; Tue, 17 Jun 2025 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652412E3395;
	Tue, 17 Jun 2025 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB70X7OK"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9F2D9EDE;
	Tue, 17 Jun 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162135; cv=none; b=DfVyZJ5YS8e95CAv0HLwdRI9d7OhLf+11UAwDkhWkPIkvZSZ8Y7sW2S3e6UBnXB47LPQAme81uVfpKVzdVIq37zTQJrHvdqSbRv205TwnNuB1nDyhnW2nsLiFJltKeUANXG5KqYew8WdJPdGEDKh7XdqqyMWyOboB+XfTibryhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162135; c=relaxed/simple;
	bh=hol8Y4KAFEPlWLZf5l4HrmnpL7xNmLx4AE9JLBSvKLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Za/sb7TJL0WlFfYUPRhCzV0Vst7Se4oTD2mRGyzRGEbLQ6lhoatzuelGEBADQWN5PR8i4iUYOygSEiTI/LUc6TZF2b7+3mCos1whEezz5a+dc7lXZvmBy2ZXJL4O50Q6MdeQevdNbXsHnN0XbSGLW0Eev2ZXOMjO+Ht2JodYD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB70X7OK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so48982935e9.3;
        Tue, 17 Jun 2025 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750162132; x=1750766932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr8tf490dLZcrTR7ZRtUOPxPJ+C3QiVC034zaGj7oxY=;
        b=kB70X7OKz4bzu3EEv9bZZ4V4Bh+SVncjy3ie24fjmH1ziD5DIHPkUHrz9hLTJDTDUH
         XN7ivPotv5C1pdWbjtN0hAJ/+g7Lg4usFKMm4HXenYb3D4RpPTSK5PkbBYHpgYIBfubS
         f/Aut/Sm4HJnwtnVA3bB8BFz2PqNcWQDadkE9e2VYqgp/WH/GKSZbRnCfH6yoWp/P34v
         FNMUTDbxxIvxELDOWmgDr9c1Cs7igAA4liqut7Qn2m/YJnN8P6zFuc+o+6YuIXIN1U8F
         iqrN6iBEFAlp5qtVBJv3NHAELC2hWzdMa4F9w1WIHsY7L8P+7XqxI3lzgYiKnKou1xe8
         Gi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162132; x=1750766932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr8tf490dLZcrTR7ZRtUOPxPJ+C3QiVC034zaGj7oxY=;
        b=sbg0NUIZIHjETwhX6Qj/IZJuKIHB7m3LpL11p/OZDomc6b2UoGGqfM73PTBFmQOzeo
         Cee6cxaR8zXqlffCX7Xv6N2/umT8BS2A9/z8dmlf0nhPbnxV+vmkCKrOw4KQ7pIz5aSp
         kGjmdfkBrM8SjuHbJuB7nffC3MuQlxNMgV9Ubwb6x86F6LtCJDMGh/kiXswhxvem7o8d
         96VzXInETTONEU6CESDmudYHd35eLANA3VmOpdHWYneq02npM3wM1w2E2805erZKZ9sZ
         gWtNFj6w+s79UGby/RsgjMi4cR+OdRKBP2aXH1mWyDjW1WaRUYco45Smc2miYP8p7K/G
         0AAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOarPpPeYmkqyYms9bC0xS5dVBudzDsxHjMl+nrhLNdzK5OzXr/yIwbYsLB0dm1LBT6/CKPROjpIxX@vger.kernel.org, AJvYcCWnAFM5vSaehI3iHKaWCkCM7srQqs+2hWlwI+tljzdwqmGwEnLwaJGirI28VNCVMdsltJ3/9DRb9sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCegKrYianyRoyztqASdwAw/v+XokcBpRbGDRyUXiteWXUBUB
	jKKTm2Yo00Z6wCwM2mG2jJRFTRMnJlvWunG/xIDGznf5b9OYZOnEvbm0Uu+akA==
X-Gm-Gg: ASbGncu1HNz2gABIYhHtoBbJklPSmEtnRuKfGlakBhz5efTk4cpec3JhPDWckjg38hj
	/L9efRgkmJr+rpsZbRn9pxYG4yA1WEq0jj/WM0s6uzC5GpF2lHCVluovoWeX3OEKk4vr7SdzrDU
	SDkHmlCfavCsXVgRSq2SxDmwz1wOnNAGgmyReSibW+iqGjgab5rZ6DkDmQw6evuApyApL9vh5Iq
	Rxz9ZftK7QMWvYw1piWeFJeuWzapgCC9u1Py1nTOhSq6zwhe0tYoMGADgNHdD39fXQyCRTRYvyB
	gRjRqoJJ5Gz/WQo3CJstgJhA0BR0eb+MBj/bTbGB/9XAtwQP2JQRl8D5duweJkitRsJGnHO2avh
	l1KZCLOabMyKPbiu5HRtYlH1W
X-Google-Smtp-Source: AGHT+IEIOX1GzSo473MBZ+UaEARhaHXuzm5oUIXccFwfpiU+QMAiIUkNa3q26+k+e/fOeO+ip3BxCA==
X-Received: by 2002:a05:600c:630f:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-4533ca8b32fmr156454475e9.10.1750162131655;
        Tue, 17 Jun 2025 05:08:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e22460bsm183509415e9.6.2025.06.17.05.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:08:51 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:08:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <20250617130850.4f558701@pumpkin>
In-Reply-To: <20250614134858.790460-1-sashal@kernel.org>
References: <20250614134858.790460-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 09:48:39 -0400
Sasha Levin <sashal@kernel.org> wrote:

> This patch series introduces a framework for formally specifying kernel
> APIs, addressing the long-standing challenge of maintaining stable
> interfaces between the kernel and user-space programs. As outlined in
> previous discussions about kernel ABI stability, the lack of
> machine-readable API specifications has led to inadvertent breakages and
> inconsistent validation across system calls and IOCTLs.

Ugg, looks horrid.
Going to be worse than things like doxygen for getting out of step with
the actual code and grep searches are going to hit the comment blocks.

	David

