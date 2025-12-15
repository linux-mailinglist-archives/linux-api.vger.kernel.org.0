Return-Path: <linux-api+bounces-5534-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4700CBF54E
	for <lists+linux-api@lfdr.de>; Mon, 15 Dec 2025 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4562B3012761
	for <lists+linux-api@lfdr.de>; Mon, 15 Dec 2025 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E915324712;
	Mon, 15 Dec 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWcISiYv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F693242B8
	for <linux-api@vger.kernel.org>; Mon, 15 Dec 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821584; cv=none; b=RtZfSs8J14hpXavR6nvtIDoBjWvKkZh/Wvq6GqYJaRMr5pTjY+Y4YSzI3i61l/56vMTFN76dAsjZz6y2qCPJPYQ8xZkUbsYC3kNlVkWtcqGdncfm8MuKUIU5I6Drot6x2F4vehYuVJ+ea4BiDu+nbaFVKofrlz0LLq1LQJfyInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821584; c=relaxed/simple;
	bh=rKVKnsmZY5Zk5WseCbLhC70tZU73oYSI0ZX68nvqOpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgNhlcnxX4w4PKrkTVsnYceKQ+eF4/FTUHGXa8VgEXtjjYWOjMItBIqVO9PKMlCmVTbGcxGPn4/6uUA3fZkIYH+4BCrSmFiN8JmIntPoaM/wSmcdyzSFHt86DxXlRpO8A+AINXOzdhme462ISn4ZyAdO+QkwwrDaZUhVlWFdkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWcISiYv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so4174750e87.2
        for <linux-api@vger.kernel.org>; Mon, 15 Dec 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765821580; x=1766426380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=mWcISiYvQDMyWrcSRycAfbgC2LcfDHeiHNEwlrIHZIiej1AYC1xSGsNIQAQ09hrYkV
         JX5RKvAXPuBpvT42pleeeJWKLBH2sgmOEqfv/KpJmG2j4MZwEb/VhmN2KUWZSKmpR4y8
         W9Y9TRYiK/LUJSWBxJeCtVm6+grs9CMML+9OjkE4C8237semIawFtJN/0+n1tfa/B4sH
         4PXZxM7CBczsbeXD5LrxS/cB7X27CZ/SgFLeQqgNRSooR0u6fqf5viqD1bfmET98d1BJ
         y+OTGkBGOVpj54S8EoEEBS6SOazJkp5BEh/6fqKDGAxYCvW45iAXLY5VypDKgUjIZ0ta
         NCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821580; x=1766426380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=jPj4cazdw1GV2uriVDp9l9nXb8pfqP9gw8DpuaXOnoe/rovuuaj8blaC3+ivkzxWJl
         tR7X3Z5cFRptrZBUY4596/RV6x/gqDNrE2VE1SZBNTm+o4X/36r2FT1tO9r7nVSARiEh
         WnpU2Ht1jzRJaz9O3yaRXEu94qHruYFeo8TJQkUI5A5V1vfFM2GRSrfVv3E35fNUPpMt
         KpdEx24cjvdxHKJRAHjpx57MF22zO4wFl/tJeyV5WexVK07iBTN1A+/utUbBAZEo7Ixf
         6hzp/MnHKjtYAmKVbIMavigtwnu/0EYeEU+7QXu667kP8NyIt7oAZlZSSdm07JaOA7CN
         k/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK52Sn9EYx80LtPjxfCvFjl+Fdr0QJo8u5e2QRtI5YynRaNZncvFXBKxK4mT0crWvhVbC3oA5wYDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwCuU826u7lkYtzEmWjdDkKtAtupnf5tNQE+7jijQ+KW6Bc1s
	Em1u1c7FpKJ6o09/1cpn372lMyWQ1rnL8cEgmO8+P71nkOOJjmZqblNF
X-Gm-Gg: AY/fxX6Nt4xOeg6lPy/N62V9Rj1TqV9pK3ggSDq/URHBX6dKGHesb3zJ4UQxYG42tY6
	GkO8WHi82ZI/nKAXA8aPSISRjdO3PGH3hhFbUAzBYU7l8pArZ/ixXOJOCYO8cCDW4pVZd5B6G1P
	MQXuRAIUcmhXbtDVita2e9GtY5O8gnX4T95rXLyn/Cc6LQLXlzLyrSPvbMvyxBrQj0FcMxJVbb7
	c1NsgUAdTOJoLW2nUJfxDCE3dy/WgaWkxMLYa3U5G5vPyK+cjvpES4qWcRwLzDjYCeGPsjLI/Fz
	G73BqJ+tXxhgtQm0/BPjoIV1ZXFltOn67UP4+YPq+RvBZIehx8qniVhnxJa14GvS/paIjRgW/VQ
	0ChjtDDR7JKMo6tgUQAxC0qeQzsn1OPkyiBLT4uiIVPCiEBILG3OSddXgvMc5Tbs4n0Ht2CN2rn
	d8WFGHYQWC
X-Google-Smtp-Source: AGHT+IFsDUVoZATaLzj9N1/hjfRE03GZ2gIP+Qj4HQeX9tt2ONoJL779FMDFpau9DQULSPR5u/L2Cg==
X-Received: by 2002:a05:6512:1154:b0:597:d59a:69ca with SMTP id 2adb3069b0e04-598faa4d5b5mr3889154e87.28.1765821580147;
        Mon, 15 Dec 2025 09:59:40 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5990da11dbfsm5648e87.13.2025.12.15.09.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:59:39 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rdunlap@infradead.org
Cc: initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Mon, 15 Dec 2025 20:59:27 +0300
Message-ID: <20251215175927.300936-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
References: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Randy Dunlap <rdunlap@infradead.org>:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you!

P. S. For unknown reasons I don't see your email in my Gmail. Not even in
spam folder.


-- 
Askar Safin

