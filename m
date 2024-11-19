Return-Path: <linux-api+bounces-2758-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FF99D2A3C
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6B8282BBA
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06C1CEAB8;
	Tue, 19 Nov 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy0wNT37"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AD1494B0;
	Tue, 19 Nov 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031698; cv=none; b=JxkmBouKk0XWQLGM8QG8DoccunAMCUDtBC6KccrkBDmkqpy5xxcX4fHgB3IfNS8EQlWj42VcR3TW1Uccnl33PqOQVPwE6BwOzNACeIXHB3Vi2wUeNmLEPhdbhDmkswwlWTyFIOE59qSL8mmFR4+CyepUv9IZMWN/rNCVLWhGrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031698; c=relaxed/simple;
	bh=wEjAah5zEPuHcYGbXNqOnH2lqRID3IPlR5FNlAtk7Os=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qga190dtkm1BCty7jzM2mhOxKO0B1mSZvtFkm1g+fTuKwLiBZf8p6pQakwZAIaffDyFPltMXkE1q13cGdc5Cvds0oUjsL8TyjEqsRf2kY+l7YLm/Ocf8As1xSjrYtzsp1gDD76txARWMKD8f+/AwL55jgMm/KTnzlCRCGuGzcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy0wNT37; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso177323366b.1;
        Tue, 19 Nov 2024 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732031695; x=1732636495; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufHarWrws7Le4/V6Knf71CxQsHIVT9BsXNQKY3qJds0=;
        b=Sy0wNT37z1FOAmSsRiebSTUxxU60pwgMlsMT+Vs0YUOcvaf8NKlfVO+IhG2cCiIE3H
         F3DNr5y7Ijw90DcXAkpTQGIUK6QFLsAaIOxmGMr8MyUMUvVlufpMxOxt/I9sMh9V4ZT3
         RYdemSXbGAE/qibXnzVPontu6MSQa/5rP7kAUbo2pfr5YjNm+Pb6iSa+xwRj8UBx7giW
         S9ydIj3z9/9ce3MCv5cHQtPVeXnL/PeE8aGcECPTXjadeeJZBwKd5KPY+DQc04yd4yPx
         rULOsJjh+FustDMtmUJYNZSSkbxpeXc6x2bj2ea8dnJ5cjaJfhQKAKHJh60OjJFmjDxE
         mtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732031695; x=1732636495;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufHarWrws7Le4/V6Knf71CxQsHIVT9BsXNQKY3qJds0=;
        b=LNVi5r5X6av6IlGbC0eP+7pAiStZKvJe6F130pm9N75K7X9KSYFADJhFOrJ6oB7yuX
         /RwzzNs4HnB16MgImpiKJrrav32Wjxy3B5/52TTXDAw4nyGecF27N0IQ2D/Y2egQ7+Wa
         RieyZ271FRkm+0nuv52xZ6W5zU1Y/yg9/qX5CfgbTwUZovbQsxF0I0ZNroRNYTtZa45T
         UcFHcV5jB5FnS7oH7E/uP/rhK5c8kt5Oc5FTVrHlkGGBpQy3y5B1OFDpyYBOmQ4Ieqxh
         DbR7UaH+f3JzjNSV8wGPXe0Kc/69QCgEQvcvUr1KgKBa9Uf3iA9ZL+EoLTGQ9WugaauN
         Jibw==
X-Forwarded-Encrypted: i=1; AJvYcCX0oGBy5D4z6ch4q5rasy6EgZ9ST8AmVoL7tNXDkLEksfe07FfaWSVA1uyb0siJ+vUPvd/ivHce+1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1j7+vfa+pxH5vPyCx8IfLbXsNprrmfEjIBSwej/hvPaahs2lm
	F5aGYlBbYnyhCNSFWIEVSWd54g57y4SHOZbnmVvPB0FXIMtzxUYjbSKr
X-Google-Smtp-Source: AGHT+IFrURQ8XZTy1H+b/WRZbZU1bSzMJ6aKQ2zyvN6xnKnsAbvS5YyDNgFHi/tpygZIfRoW7v+/Fg==
X-Received: by 2002:a17:906:fd85:b0:a9e:380b:8ce with SMTP id a640c23a62f3a-aa483483a44mr1539477466b.35.1732031694695;
        Tue, 19 Nov 2024 07:54:54 -0800 (PST)
Received: from p183 ([46.53.252.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043b6bsm665096266b.140.2024.11.19.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:54:54 -0800 (PST)
Date: Tue, 19 Nov 2024 18:54:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH] uapi: add EROBLK
Message-ID: <9184b5e8-7070-4395-b179-4975b2e3fbc3@p183>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Block drivers and DM sometimes use EROFS to report errors. There is
no confusion about what happens but naive error reporting code might
pass -EROFS to strerror(3) which will print "filesystem" when clearly
there is no filesystem anywhere, it is layer above.

Or in other words, if EROFS exists, why not EROBLK?
It is not like there is a tax on errno values.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/uapi/asm-generic/errno.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -119,5 +119,6 @@
 #define ERFKILL		132	/* Operation not possible due to RF-kill */
 
 #define EHWPOISON	133	/* Memory page has hardware error */
+#define EROBLK		134	/* Block device is read-only */
 
 #endif

