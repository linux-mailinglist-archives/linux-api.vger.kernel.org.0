Return-Path: <linux-api+bounces-1684-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5C90093A
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315791F21FDE
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032C199253;
	Fri,  7 Jun 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rx09CVtk"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025D19923C;
	Fri,  7 Jun 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774384; cv=none; b=LX1Icovnn/+eJJUzxHPFbFBvRWVCqlZRuLZc1IGeuEluCNGVPu/ZGq7ECqJwKwT2cBLvbr6mjNSvFpKxMCr4+3/uHB8fIfdE+u+JnJTUjMRO9LYR3MmzIqrfTmOq8QzKWr0Suqv0x2ZfMQhHIXd5OGQxKAZ1WW1fDB8wie727AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774384; c=relaxed/simple;
	bh=iA2i+g2wTu86Q04x1/Mccg6UPGiul5W8OAQcSTpjQzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p544TZ542Xw5TuNq4OnBlpsgdZWft/eMZGVIXS7MBv9tA9zKm3aDQAoNnS77McXJz621GihY2KGoSmdVzpznFOlW7vAwYKpmGbyt4LZSvd5eq3Z1wRlvR6xm425ILQDvN7f+hldBMn7CyBbF8wlSHIFldc2vkMARvQtVrETFa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Rx09CVtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2282C2BBFC;
	Fri,  7 Jun 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rx09CVtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717774381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHq94GHF3GdMXYFHCpfZbCia8tYe6XNuXS1o9WgDhFs=;
	b=Rx09CVtkP5YBlCzr0H2yCq3zMqkznBCz5bK2ar/0TvFxWsx4WQisGmz0Un/b2cTVW25+QA
	ZlbHngD90FrDqM4qy6PHUytJY828sCQv9aLnXv1qFelY52eqFf5eX9j4I3ElcZeAimPg4D
	I7sWmwI93l47KhhDmpPFMgWUDaoKih0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c03b755c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 15:33:00 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:32:54 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>,
	Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v16 5/5] x86: vdso: Wire up getrandom() vDSO
 implementation
Message-ID: <ZmMoJkqIygnUziXv@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-6-Jason@zx2c4.com>
 <87y17j2hk7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y17j2hk7.ffs@tglx>

On Wed, Jun 05, 2024 at 11:41:44PM +0200, Thomas Gleixner wrote:
> On Tue, May 28 2024 at 14:19, Jason A. Donenfeld wrote:
> > +
> > +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> > +{
> > +	if (__vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
> 
> Lacks an IS_ENABLED(CONFIG_TIMENS)

Thanks, will fix for v+1.

Jason

