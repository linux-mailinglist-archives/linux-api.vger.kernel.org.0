Return-Path: <linux-api+bounces-2210-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504B1958809
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2A2814E2
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5118FDD0;
	Tue, 20 Aug 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FNstAQqC"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F918A6D1;
	Tue, 20 Aug 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160977; cv=none; b=eljBy64xli6XvDP7MN5+qipe/RJmIuTpAfYLJUtP6V8+Eiz05aD67v3ja72t6PZzofiZnevoFMa3kbupLf31IskvqdILscdhbqEUhvK78TXdv/PZTdDGvWL4CQrh4qhQqc6pC/7Pfcw1Pcm2H9gAJSuyIgc5seqaPpV4ImLLKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160977; c=relaxed/simple;
	bh=xrLE4cpUlfjYy+rsx7yigeDMXs1rHTxyM1ByL1WqLIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hubJ2FW/FZ8yDMSYOpT/oc91jxOGOdNHmKzqTouy87SSu+FySyfym4j1uSC7fNWiT2A12y9tkQ7PxhKTCV7wGPTFw+h4S/XOihhtsdcOFCXPS6IgjRBW1oOGmB1tipEZAPxE0bwfKkTW6Jc0rebIeQCDcnGlf2mXdAH6AqxOp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FNstAQqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00DDC4AF0C;
	Tue, 20 Aug 2024 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724160976;
	bh=xrLE4cpUlfjYy+rsx7yigeDMXs1rHTxyM1ByL1WqLIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNstAQqC15bswq9vfn8uc54fCpyrldTsgv0xv6bBdBrmgLHhtkvdjza7BtnORw4BP
	 QViAyvg3iZn/y8hFIozLzddOaRI5Puvthyx/9esFCiDnaz/uaF57zer4UUbbdVNG3U
	 KskapMK17wO/lrtl8r5N7gqcQQ1TjPAfXSqPm5ec=
Date: Tue, 20 Aug 2024 21:36:13 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
	linux-api@vger.kernel.org
Subject: Re: It is correct to introduce new sys calls to stable versions?
Message-ID: <2024082057-coherence-lethargy-3513@gregkh>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>

On Tue, Aug 20, 2024 at 09:19:04PM +0800, Miao Wang wrote:
> Hi, Greg
> 
> I saw you have included commit 7697a0fe0154 ("LoongArch: Define
> __ARCH_WANT_NEW_STAT in unistd.h") in your stable trees, which
> actually introduced new sys calls newfstatat and fstat to Loongarch.

See the documentation in that commit for why it was done.

> I wonder if it is correct to add new syscalls, which actually changes
> the kernel features, in stable releases, as it might confuse downstream
> developers because they may assume the existence of a certain feature
> after a certain version.

Version numbers should never be used to be checked for anything as they
are only a "moment in time" stamp.  They do not reflect features or
capabilities or anything else.

Test for functionality if you want to check for something, that's the
only way it will ever work on all of the variants of different
"enterprise" kernels.

thanks,

greg k-h

