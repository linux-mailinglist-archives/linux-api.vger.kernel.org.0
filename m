Return-Path: <linux-api+bounces-1639-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E218D1CF1
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9816A1F21C3D
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6306216F0EA;
	Tue, 28 May 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Wm1QN3Ry"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481A16EC0D
	for <linux-api@vger.kernel.org>; Tue, 28 May 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902913; cv=none; b=MEQTCV8ny0yb0JfoZVsED62dAkDiTYLBbL0o0esLgrYutemBTEH+gIe9t2p4qXCZIE3H+0cq61dOxlkMG86Jpj18EoPu6rjiuuFUwyhfsjWHC5VBmr4gNKRyLP/s/yqAgS2PZuecyjRSEsfWEBEiSzt8rBIyX0GhXdkqjIbveKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902913; c=relaxed/simple;
	bh=PBBLOV4U2IFgFSKdFT4Y43aEoeT6Ow1hJwKRcZckZ7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI/v1+qhLXZSuHiL+dI3xBlo+TPMGpfWeWQuCgJBQvseSJR18q4TPkptYonDvjLavklzumeDqABLo/yYA8MpnD5vBlPXSqKPFLTaqhjaiTWsNhoFGt5MPtAFuq6d+TUVwBWp/fOsLiRZSa1KnzT4cdMT5jyUMqLQ1ebwX4yTLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Wm1QN3Ry; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6303e13ffeso98827266b.3
        for <linux-api@vger.kernel.org>; Tue, 28 May 2024 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716902910; x=1717507710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBBLOV4U2IFgFSKdFT4Y43aEoeT6Ow1hJwKRcZckZ7w=;
        b=Wm1QN3RyfSowp3OP685y93x0QSYnT927aLF6A0cd+Dr/PPr3kY9GeQaKnWyWwIqKEi
         kSOmSfvQGe/RlzTCV8BXz1hM78yQtJgcvRvsgU73ezbBBMY2GvU/lxelFVGj8Hm3F8R2
         WtI+cRhoXatHfGMVm6zMu6kO2ofAGu6bZ0Hos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902910; x=1717507710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBBLOV4U2IFgFSKdFT4Y43aEoeT6Ow1hJwKRcZckZ7w=;
        b=Nlf14ifvJlO/tWPW9MsExLPT0Hqv4iCaXCuv1rm0vKmNZVngVFGIeR6AAeqGbAnUQC
         Drn31M783HkvZXBAIz0DG9JomHwIjt0jf0/i4LAimsu7MDDG95cVbYo8iitk3z0TDoY4
         Dk/6npYm+jgCCkKTjSrATKb/B3IDcncySAmSuejdkkroh+VRfBXd6FoQuGrs9FwMs1vQ
         wXn7SaF56PTj2O9i8ttuV070lFug+H7Uiwd9DfwxAOkuZGuBf2sinLknWOmOBXhgDWpW
         TmeY6XW5YkoB0dZic3Uf71J4szUZJCGV8hDAkEYk2dh0cckdvL03OLrmKtcIq/G/hxzF
         GrPA==
X-Forwarded-Encrypted: i=1; AJvYcCXjuF+CmY7ifEONdrlnxSvv+ZqqLv5XY2Koojf00f/NS3VsTazOWRTgSonybz+/qLPWJEua+LtZknnUzgTt2w0cABrqcpp0Qxa6
X-Gm-Message-State: AOJu0YwlMdVFh65cKyTUkYaVz7EVFSagXDBiWJwkRGAA0I7HO+d9NfCp
	c6RSIBpWun7WHcGCTtLwxMn+PBxSqdFKhPVg3vaWMKB6SGs/doFjTm3JBoPW3+3nj3IaPWit7Cd
	zrBbOX55Lb4LoZ9B0z6QWVIEeGnRB5qsuLKGFhA==
X-Google-Smtp-Source: AGHT+IET1YleTWVR5AXg8CRN1Esbkyz90K8kriJOg4HbyfAsDwmoVK/cGg98h3bhg32ByJBXHFEIavMxNd8QwGr8f7g=
X-Received: by 2002:a17:906:788:b0:a59:adf8:a6e1 with SMTP id
 a640c23a62f3a-a62651144f1mr794014566b.47.1716902909983; Tue, 28 May 2024
 06:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZlMADupKkN0ITgG5@infradead.org> <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org> <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org> <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org> <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org> <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
In-Reply-To: <ZlXaj9Qv0bm9PAjX@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 15:28:18 +0200
Message-ID: <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to name_to_handle_at(2)
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 15:24, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 28, 2024 at 02:04:16PM +0200, Christian Brauner wrote:
> > Can you please explain how opening an fd based on a handle returned from
> > name_to_handle_at() and not using a mount file descriptor for
> > open_by_handle_at() would work?
>
> Same as NFS file handles:
>
> name_to_handle_at returns a handle that includes a file system
> identifier.
>
> open_by_handle_at looks up the superblock based on that identifier.

The open file needs a specific mount, holding the superblock is not sufficient.

Thanks,
Miklos

