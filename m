Return-Path: <linux-api+bounces-2212-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADC95885D
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9A81C20DF6
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E11190698;
	Tue, 20 Aug 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XiOYFqhJ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448218FDD6;
	Tue, 20 Aug 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162439; cv=none; b=S4kddgxbvSCAO3cB6xDLzIXGm0axdPrfopRs+903/YZqVpEsYLz7Wv6jZIWpABZJ4cjBj/0Yxo8vXP1ELrKqsTMNAvbk74QSlafS7Kt4vLbgLNZlb6mPAP5gbQuVS5wVzRNU2KtaPC2y7HVhPqzB+/8tVYG0PMT+768ROv4yv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162439; c=relaxed/simple;
	bh=obQu1LmcUROvlT2x7IIL7X01Sg/V8matNX00+XbROMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q56swVyXAFIx/RPJBi5duaEYyQ7xHXKFyere7QhrYkGOYttKYwBrekKfiIrySfOMiGgGo7LXHb69GZ9BoqZVZOFEfc5VY9jD7mytMav5X/Cc3HxgVB7S7EsI2N3KHKn+77nIYPe28qAFtncKuc2TNjLE2KLGY2XIdjEQWcwQVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XiOYFqhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E572C4AF0C;
	Tue, 20 Aug 2024 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724162439;
	bh=obQu1LmcUROvlT2x7IIL7X01Sg/V8matNX00+XbROMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XiOYFqhJmiDJBcIbQ9DmJXIatdqUO2M8GhnphpYLLOr85feum1/7SsWWbOHo6BAYI
	 bVlb4umxlidJ32ehE9h4G/LyPFZxQVuRAIpfwgq4tv6lGrC57oM8WOMqp+fCYRBcua
	 WYalzGK9HLMhDcfb9OYFlHbTKr8gZGKDzTCQKiHE=
Date: Tue, 20 Aug 2024 22:00:35 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
	linux-api@vger.kernel.org
Subject: Re: It is correct to introduce new sys calls to stable versions?
Message-ID: <2024082027-deskbound-rumbling-b96f@gregkh>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
 <2024082057-coherence-lethargy-3513@gregkh>
 <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>

On Tue, Aug 20, 2024 at 09:49:59PM +0800, Miao Wang wrote:
> Hi,
> 
> > 2024年8月20日 21:36，Greg Kroah-Hartman <gregkh@linuxfoundation.org> 写道：
> > 
> > On Tue, Aug 20, 2024 at 09:19:04PM +0800, Miao Wang wrote:
> >> Hi, Greg
> >> 
> >> I saw you have included commit 7697a0fe0154 ("LoongArch: Define
> >> __ARCH_WANT_NEW_STAT in unistd.h") in your stable trees, which
> >> actually introduced new sys calls newfstatat and fstat to Loongarch.
> > 
> > See the documentation in that commit for why it was done.
> 
> Thanks for your explanation. I totally understand the necessity of
> re-introducing thees two syscalls. I just wonder whether there is any
> limitation on what can be included in to the stable trees. If there
> was no limitation, theoretically, I could also maintain a so-called
> stable tree by applying all the patches from torvalds' tree, except
> those that bumps the version number. Apparently such a "stable" tree
> is far from stable.

Or you could do the opposite, something that I have seen vendors do, and
just bump the kernel version number to try to "claim" they updated their
kernel to a more secure one (i.e. one that fixed loads of known issues),
but they really didn't.

Either way, it's your kernel, you are free to do whatever you want with
it, have fun!  :)

greg k-h

