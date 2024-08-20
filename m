Return-Path: <linux-api+bounces-2214-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01614958AB3
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 17:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FFD287B09
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E834191F7E;
	Tue, 20 Aug 2024 15:05:28 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD6A2745C;
	Tue, 20 Aug 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166328; cv=none; b=DR7PZkLE/o16mpytP/rQYlv9WYbWQp1Q9FgYue5D6C0RE3so9s+P7mNWLnoo85XZ1ur3jYM9sKZaTBaeWoPIoLogeFw6YhKGOpBBkAw4R5nsPjwDn4MzwuDEGs9eKd+Dv2wbV1jmw9P1Ar6g7uOyjBSZ+b7zYkiAfWRVbEaNqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166328; c=relaxed/simple;
	bh=NksgYIxszhgKL5p7NNWlTc6B7nORK5qVIF4Ln+rIYUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw0y8upLMLBb/IhFGtTKzHVwSnFqIc7aPES+vZDDh6wAkkAHoyJLw1rRN5ra6FKK1gdDOfLQQCr2xrmeYEuS7jNDpldVJw1Ij+cYfEuCI33ztUUqMLN1fvHLM9n2NZBtNInxxXCDxBOjt3mN8K/3K8P7lIJnwzw9ORbBoTIQyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 47KF51XM015749;
	Tue, 20 Aug 2024 17:05:01 +0200
Date: Tue, 20 Aug 2024 17:05:00 +0200
From: Willy Tarreau <w@1wt.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miao Wang <shankerwangmiao@gmail.com>, Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org
Subject: Re: It is correct to introduce new sys calls to stable versions?
Message-ID: <ZsSwnPfyOvdSBMOC@1wt.eu>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
 <2024082057-coherence-lethargy-3513@gregkh>
 <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>
 <2024082027-deskbound-rumbling-b96f@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082027-deskbound-rumbling-b96f@gregkh>

On Tue, Aug 20, 2024 at 10:00:35PM +0800, Greg Kroah-Hartman wrote:
> On Tue, Aug 20, 2024 at 09:49:59PM +0800, Miao Wang wrote:
> > Hi,
> > 
> > > 2024?8?20? 21:36,Greg Kroah-Hartman <gregkh@linuxfoundation.org> ??:
> > > 
> > > On Tue, Aug 20, 2024 at 09:19:04PM +0800, Miao Wang wrote:
> > >> Hi, Greg
> > >> 
> > >> I saw you have included commit 7697a0fe0154 ("LoongArch: Define
> > >> __ARCH_WANT_NEW_STAT in unistd.h") in your stable trees, which
> > >> actually introduced new sys calls newfstatat and fstat to Loongarch.
> > > 
> > > See the documentation in that commit for why it was done.
> > 
> > Thanks for your explanation. I totally understand the necessity of
> > re-introducing thees two syscalls. I just wonder whether there is any
> > limitation on what can be included in to the stable trees. If there
> > was no limitation, theoretically, I could also maintain a so-called
> > stable tree by applying all the patches from torvalds' tree, except
> > those that bumps the version number. Apparently such a "stable" tree
> > is far from stable.
> 
> Or you could do the opposite, something that I have seen vendors do, and
> just bump the kernel version number to try to "claim" they updated their
> kernel to a more secure one (i.e. one that fixed loads of known issues),
> but they really didn't.

Some of those who do that don't even notice what they're missing. I've
seen some BSP kernels "forward-ported" by merging the next bunch of
stable versions, trying to fix rejects by hand with the usual ratio of
failures, but after that since that version is part of the history, it's
impossible to figure what's really missing or not. Some people don't seem
to realize that *merging* code can actually result in *removing* fixes.
So they don't even need cheat on their versions, they're genuinely
believing they're OK... which is worse!

Willy

