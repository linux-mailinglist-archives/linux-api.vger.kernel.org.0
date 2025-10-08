Return-Path: <linux-api+bounces-5028-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE4BC58EF
	for <lists+linux-api@lfdr.de>; Wed, 08 Oct 2025 17:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C282419E34E5
	for <lists+linux-api@lfdr.de>; Wed,  8 Oct 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8222F3607;
	Wed,  8 Oct 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="wH/TZyCi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A31287505
	for <linux-api@vger.kernel.org>; Wed,  8 Oct 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936970; cv=none; b=jsEwsMBssA2JrcJz09tE18ZzGA1YTlTGBsPpf3tW3ZwuxU8XgPQzsri3FDFh1WrFzMWz8g/0i63s7borGCUvKxywPOXTWp12zh4R4OugqY++s32DBZB2w3xTQDSuttqtyjQrHPhQUr7sBa3aq8vXaPwiokuAuJvjQBRg4l1DJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936970; c=relaxed/simple;
	bh=X1j6nGmDxjSgXJyZIZHORQDEpRM8U3EkbVPt5CtrEb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COUlpDRmcJm/MFAfEwrSxF2gM3+QFqZQRAuiZHJXtnweqbdt5J4y48JrvA4o3tAS8CtPJgnAvBs6+itJQKHeCGZGJr5t5bGslDp8CNtdfyI5xJnEZbLleEFpePzoSK6Ufe3gVw9IjuTlwVc2Dv6yE4wGuR8hzJ8YhHk+g56bGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=wH/TZyCi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so8441632e87.2
        for <linux-api@vger.kernel.org>; Wed, 08 Oct 2025 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1759936967; x=1760541767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ46KU8vSJ3Y3y6MyDJK8NolTC55ZuDRWc/GesIulFg=;
        b=wH/TZyCiKjKv7+x1usMnk0IwMqV76nioJGeK3SB6TgBjtGUaOjVjO2oLMrtB/aW9Ll
         3ipjaBaXOtWsuDOFE1oK5N0VTnHWK8gQIe9JQBRNiHK7+Ml/T9UQxiJebMfWzdqEeU9q
         rRXR/6OkTFyrrxfYVovb4xylvPM2i57hw1vh4tFL/ym+zb/5DE+ueg8AqnsoXOo0esd7
         RaRxzHqEfeRIOCEEp9EM5mHhllqnY/Ybco4Ez88jrxn0xfu2vOieDe5wNYC705RLC8jn
         p7NwpIFk4ctnPptyJVofvapoQk86CjKIPxpY8sIrDRqfpgkR9eVaWad6N7f7zF+3aCfk
         FqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936967; x=1760541767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ46KU8vSJ3Y3y6MyDJK8NolTC55ZuDRWc/GesIulFg=;
        b=kEj2KpZ5ie7scYjbiFNwF8hw/o7QNr4/FzD2M3f48rcqaweVT3xnr1CtrIN/7g5yYM
         i5ZtROgVL2B5w7Eb0vxVkc2Ftce9HA4i9dKTopoda55AMlm0sPF7tbeNZC7shILN7New
         iEJf0/uf7lZPu22R9BG+rniTy6QxtCDSdgkg20nJx4xJ3+KxuQkdwU0FUs4dru2KMShc
         nLGaKYcxAK077nzzdaadlUGazFK1wWCXVdL7KCIxOJIDNCvXYaZLQtfdXHdMumNVi3Vv
         klcrpZDYstOKmjVD3rh8OlhMiOWtilw9/ageG+4UFmTfFcbofCDn23zSirJDIOsUOUf2
         EkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLgUxOE4MriPjm9bfj1RKRTApdxGysMBZ8JBNJTzBO/zmTq0+7kJ/5VgJM61OiIeg9XgWtan05sug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+TKU4LDaC7bD0W5kLiRnMRglygtttr8fyiqvDgzXrmyxGw5w
	8MuUaCZjrNuiIRVeRyslc3MtwJq7WWir2gsiKcTXOifdLkvU9AysZkDf6oFA34Y3Al1D45xZb23
	myXOqNZbsBx2NjGuO8+Al6R8I/Ed08GlN/yUArYTAikz+mRhyV65jJggp
X-Gm-Gg: ASbGncv+Mbhmg660Swysg9U8CdOuvZ4ZPNGoQGxN2RTSWMPoAUqopvLpFrWMPyoKsRA
	XhtC6lEnS3joCyLYGhDsTNryzoNSDCgG82Req/bLxNkfbf766sdzJe5Daslsm/X52vBM1lMvv0p
	fIQD7mdTLngyhii8GHfGczJlgzltFhfJPftnbvF2yTX5x08g3kDtfabKlp3fK/Nny+ws2LqaZI5
	Q8+rUokDmuJ4M/dymGa+8KsjXwp7g==
X-Google-Smtp-Source: AGHT+IFiyi5CBclcY4eFXl0Xxb3EcgxnRGKFTun8v5zZ9i8QJErjRPfdIvpLd3dkdEHbDYaPjeMr0Oet9rEeTUSZwKA=
X-Received: by 2002:a05:6512:1294:b0:57d:d62e:b212 with SMTP id
 2adb3069b0e04-5906d9e7470mr1160546e87.38.1759936966762; Wed, 08 Oct 2025
 08:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003093213.52624-1-xemul@scylladb.com> <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com> <aOSgXXzvuq5YDj7q@infradead.org>
In-Reply-To: <aOSgXXzvuq5YDj7q@infradead.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 8 Oct 2025 08:22:35 -0700
X-Gm-Features: AS18NWAsAb31TZfXWvQWDBORzAjx40tnBrYMOReEbyFX0MlBOKne28k_TQuZOBg
Message-ID: <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing O_NOCMTIME
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org, 
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>, linux-api@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:08=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> > > Well, we'll need to look into that, including maybe non-blockin
> > > timestamp updates.
> > >
> >
> > It's been 12 years (!), but maybe it's time to reconsider this:
> >
> > https://lore.kernel.org/all/cover.1377193658.git.luto@amacapital.net/
>
> I don't see how that is relevant here.  Also writes through shared
> mmaps are problematic for so many reasons that I'm not sure we want
> to encourage people to use that more.
>

Because the same exact issue exists in the normal non-mmap write path,
and I can even quote you upthread :)

> Well, we'll need to look into that, including maybe non-blockin
timestamp updates.

I assume the code path that inspired this thread in the first place is:

ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from=
)
{
        struct file *file =3D iocb->ki_filp;
        struct address_space *mapping =3D file->f_mapping;
        struct inode *inode =3D mapping->host;
        ssize_t ret;

        ret =3D file_remove_privs(file);
        if (ret)
                return ret;

        ret =3D file_update_time(file);

and this has *exactly* the same problem as the shared-mmap write path:
it synchronously updates the time (well, synchronously enough that it
sometimes blocks), and it does so before updating the file contents
(although the window during which the timestamp is updated and the
contents are not is not as absurdly long as it is in the mmap case).

Now my series does not change any of this, but I'm thinking more of
the concept: instead of doing file/inode_update_time when a file is
logically written (in write_iter, page_mkwrite, etc), set a flag so
that the writeback code knows that the timestamp needs updating.
Thinking out loud, to handle both write_iter and mmap, there might
need to be two bits: one saying "the timestamp needs to be updated"
and another saying "the timestamp has been updated in the in-memory
inode, but the inode hasn't been dirtied yet".  And maybe the latter
is doable entirely within fs-specific code without any help from the
generic code, but it might still be nice to keep generic_update_time
usable for filesystems that want to do this.

--Andy

