Return-Path: <linux-api+bounces-1971-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4D931FBD
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 06:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE09B213D1
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 04:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D5411C92;
	Tue, 16 Jul 2024 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfxiQq/e"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613517556
	for <linux-api@vger.kernel.org>; Tue, 16 Jul 2024 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721104704; cv=none; b=FBIfTI3JGrwgd0sKD2/pBrIFqbgJC3cShhgIQ2mcSDsxM799vvFJu5c7+LuM6pxNQmNkw9BsxZ1oo4GvFModY76HnBMTdjVtZ5vvYficKEQv/738OtZE39Gt4124pBHbE59w8GW0CeBIWIt+eEKZ7qWnCrjRAQNKrPjwgAZYY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721104704; c=relaxed/simple;
	bh=ztt71uxgqQGaS1jupaXZbcJdohblC5lD4CiMmk2sDXA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=J+SaWBdLY0jpZeefoCB+MUhie173WT+rGiTzk8vEZZYioGnlPeXy53GnbKCLBsflhNfob74kuSHiZcuSR4BMvoUHTXEAR6/MKAE5rg1ytqNvsCinWT7qAIEWIEfGtE5j1fYC7kQs3Mtx82I0BFtlvBUxfDmTlcvohO5UL37FOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfxiQq/e; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70388567d24so2888022a34.0
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2024 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721104702; x=1721709502; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6RYJet4RQukgf9/gOwGFhMgYHqkPIZETJ4In2JBN77A=;
        b=JfxiQq/ePZfOIHDc/unxOh7oIYbjtOkstFIgL+5EHn7neaF1S6EbbaDllOwV6wderG
         TMTaAWOqEhfat/dErD0DJEcOKE2tS57ydymXQCO9ri+MZ6IfQE9DTx8lEZrkbByGLIXL
         +m4UDDNSrq/lOKrz/xBAdQNs1bNK+gItI9SnDGT5IvTmsFLlYEOnBc2zBm3QFkeu0IAz
         7fKQGz+Ak1RRV6Zh7J5e4Ku6DlLcabeBjOYTN8HqtVQ0DDPu+YKodJ1ZE6nqifcRkXCf
         hpuRon3hGGal5pFbCsEXPBCjfMGMlG9q3qnYF/CgIdhEJ6yjseUbQhkiLU/FaeR1qiYD
         K4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721104702; x=1721709502;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RYJet4RQukgf9/gOwGFhMgYHqkPIZETJ4In2JBN77A=;
        b=abhz1OBHyk4z1trENuebRj/gV9uCWtVyQxnzYL/eMF3z8XllmvJhrqUfHvQYFxb4bi
         izBR3fGnYVT+Ie9VIjF1qAihUkG3eQNgZU/NahLNOkxBRkZFwqG3HrsndaHLBxy9KTQX
         wjuNTsDjD6dtT0vgFi12g3u9SeginHevX0fu+iMwpzr5ZoatqpeTpX1jmL0j126v5CP6
         /iVffiRyEDzkuj9fEO5e+SyhcIg+g+xOnJhSj24PKAdQ6QakQtffuOJKY16KTe5JauVh
         uFGBg2aaQnKAbW1Yt8AOfpbB9T6HQjc0Q5Z1IrODtU/3F104fAdOalNZ/figdfivw4it
         ++QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz1faOM52GSedViaQ+K38hP+3Aom/p8uWd7q8pMVoTP0VYHqo9CzmNy4fI9UkEp0+UMPARWJr0ZRRwn7E28g8Z3sJVhZSLaGly
X-Gm-Message-State: AOJu0YwkKCf6dRmMDkNNCPrDaA3SJxc5PwZzgX+YftcAyxJwdTgvpLVB
	+J/z3N8+Dx6MjDn9S8VeM0TaIDfTqY1vQqTkixZXlUA1gA2yt/1hGPRjOG7z5RQ=
X-Google-Smtp-Source: AGHT+IFuTBiSX/I/b8/1CrzFpy+eoFfX+Oe4M7y7ZGQlYD/Samet5CuV1ME9BquFP8D6J9TkXx2HIw==
X-Received: by 2002:a05:6830:6d16:b0:708:d84d:f628 with SMTP id 46e09a7af769-708d99bc4cbmr1446194a34.31.1721104701772;
        Mon, 15 Jul 2024 21:38:21 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:2914:689d:ed52:527])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7ff8csm5250315b3a.135.2024.07.15.21.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 21:38:21 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: broonie@kernel.org
Cc: Szabolcs.Nagy@arm.com,bp@alien8.de,brauner@kernel.org,bristot@redhat.com,bsegall@google.com,catalin.marinas@arm.com,dave.hansen@linux.intel.com,david@redhat.com,debug@rivosinc.com,dietmar.eggemann@arm.com,fweimer@redhat.com,hjl.tools@gmail.com,hpa@zytor.com,jannh@google.com,juri.lelli@redhat.com,kees@kernel.org,linux-api@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mgorman@suse.de,mingo@redhat.com,peterz@infradead.org,rick.p.edgecombe@intel.com,rostedt@goodmis.org,shuah@kernel.org,tglx@linutronix.de,vincent.guittot@linaro.org,vschneid@redhat.com,will@kernel.org,x86@kernel.org
Subject: Re: [PATCH RFT v6 3/9] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
In-Reply-To: <20240623-clone3-shadow-stack-v6-3-9ee7783b1fb9@kernel.org>
Date: Tue, 16 Jul 2024 01:38:18 -0300
Message-ID: <87ttgqt0hx.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

> diff --git a/mm/Kconfig b/mm/Kconfig
> index b4cb45255a54..45416916dec1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1249,6 +1249,12 @@ config IOMMU_MM_DATA
>  config EXECMEM
>  	bool
>  
> +config ARCH_HAS_USER_SHADOW_STACK
> +	bool
> +	help
> +	  The architecture has hardware support for userspace shadow call
> +          stacks (eg, x87 CET, arm64 GCS or RISC-V Zicfiss).

s/x87/x86/ ?

-- 
Thiago

