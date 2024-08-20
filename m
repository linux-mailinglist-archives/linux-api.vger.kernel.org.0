Return-Path: <linux-api+bounces-2216-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7D958E0B
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E31B21E25
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7CE14A603;
	Tue, 20 Aug 2024 18:30:43 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416E1494A0;
	Tue, 20 Aug 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178643; cv=none; b=IGXHYer9mH9XHWxsUtdV4irvoRYzZgOa51SJPy0IKmXaynHkjX/O6/m8M9wGyCZO4ZGgxS3/0JVigq/oebQj6XJCm4ADAz9RQgGJ57ymRDYUh4JWhNYCwWAKMwhS6DoeCJ0WU6TDCstc0HDOtFY8iVzA13Zwi4ScTQ72CT0HB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178643; c=relaxed/simple;
	bh=anCgAaHfG8Tm61jyfGeIZ8qm77ntivfuE4rHccrGIu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2wujZmaM+yspC+SdyXl5CWK9PHxedkMnh05FmCPDaih/KRn9Quglx2kwIu0fx7gBV4M/ifusEJHm9AeXsEfamMmYQTkCvI5lh4fyEA8bJw24wbTnJI9/JUdAOXP10Uo58kwO9ta8fSoQT3z9qErOx1ojGWGoQhchSiHDQOLgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 47KIUTnC017648;
	Tue, 20 Aug 2024 20:30:29 +0200
Date: Tue, 20 Aug 2024 20:30:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        linux-api@vger.kernel.org
Subject: Re: It is correct to introduce new sys calls to stable versions?
Message-ID: <ZsTgxUndhb04snd6@1wt.eu>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
 <2024082057-coherence-lethargy-3513@gregkh>
 <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>
 <2024082027-deskbound-rumbling-b96f@gregkh>
 <ZsSwnPfyOvdSBMOC@1wt.eu>
 <46C6EB05-1AA2-42BF-82BF-3B99CCA57439@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46C6EB05-1AA2-42BF-82BF-3B99CCA57439@gmail.com>

On Wed, Aug 21, 2024 at 12:09:41AM +0800, Miao Wang wrote:
> However, my original question is whether it is expected to include new
> syscalls in kernel stable tree. According to the document "stable-kernel-
> rules", if I'm interpreting it correctly, I expect only bug fixes and small
> driver enhancements from stable releases. I understand the patch in question
> is actually introducing new syscalls, which is beyond my expectation. So I
> wonder the consideration of including this patch in stable releases.

When you maintain stable software you quickly realize that everything
is not just pure white or black but a shade of gray and that if it can
be considered as a bug to miss a syscall in certain environments for
example, then it can become a valid fix to add it. I don't have any
opinion on this particular one, but since your question is broader I'm
trying to explain.

Different people have different expectations about what needs to be
fixed, that's even why some people will choose a distro over another
one (prefer to fix only critical bugs over fixing all bugs for example),
but there's no point restarting a philosophical on this topic which has
already been rehashed too many times in the past.

As a rule of thumb, just keep in mind that anything that needs to get
fix will eventually be fixed.

Thanks,
Willy

