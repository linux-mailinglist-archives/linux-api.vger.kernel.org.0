Return-Path: <linux-api+bounces-1101-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8287C872A25
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD39B26D87
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A56512D1FC;
	Tue,  5 Mar 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sB1T2/pm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305C12D1E4
	for <linux-api@vger.kernel.org>; Tue,  5 Mar 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677354; cv=none; b=eI8EfuCof8PKnUnCO6+xeyaFO8gJlvy6oYInoxd/JxIgTbWWNkaaqdwT43BNR3IxRt5+E3JUUD3Lg6bPO+jspal8h8FUmFtOfRG08FFuA6Y4seqQVkWQrC/YOmrYIQ8KbBk7KUQROIfOtEtkyyULJeDLPpO2NphHixTkp4GY9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677354; c=relaxed/simple;
	bh=Emvxl3JaeBEA6fYlQxKLyhCiR/NwJv573H4jjTs207U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r82rTHp4f5Ur5XchsqrjnepUX9j1zDOU9KrtRcA4ct89AjRvQ0TzZEMV2999teiZweEPUAMja2y1nx0xduJ+a2BhYTBUOvZ7opYzfmBCKuploVapdQLdlpMgE+TGnVX/RlAt684/unkhilot/GZWi4kzFDl57u2P5iIIJiMJXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sB1T2/pm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68ee2c0a237so1978226d6.1
        for <linux-api@vger.kernel.org>; Tue, 05 Mar 2024 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709677352; x=1710282152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4yaOCyORqK7Y6K5fYLxtn4q3HQqcLmWrnXZYR8L2IA=;
        b=sB1T2/pmBEPE7FVPZI41DdC+J8zVPxCrJWUXq0V7NFgb14U4RTG2xhxWr1ZX5WgNhJ
         Ie/JTeDTKpNxu08HDk58HlvBtJwWEZhkACUWQ/Z6zjyfFQI8EZdp1VFfvt/OIvyvZNwm
         2+du1UZPfF9h+EflZDX7IyDxatgcuWUBtZh57y+JY6SnPathV6jLzeUYmgVY85HdeTy7
         gqP1WOUlRPh6LctcNljraS+3ckzVKNY29yCNTgRIeok3/ny5t17U+0sy6IclvwK6Satb
         WrqLxvML5vUlDULhV7TkjChRR/eTDW7URw0Iy01opXviioWBeOP33eB/5ho/RNsvmMUj
         kAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709677352; x=1710282152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4yaOCyORqK7Y6K5fYLxtn4q3HQqcLmWrnXZYR8L2IA=;
        b=kyPLgP4bN210RW3StWyANNpa2UwUad5DxMB7o06Yau3fvHX2B+45yf9wQmGwDVcEj1
         gQfQC8L7rI0NE5uzKan3MJ+LZmWaycWdxbAXEP1LCM0Zcq+NWxgEbVZy4Jzmu58CdniJ
         FMqt1qR2zLG3qb7XTqwy5a7w1guhWCBpQMuKM+nlaZBqB1qLkMV24kolIyPTdjKhDQFP
         ULeTrYos5PXSguA5CLFggQy3HSa3RcKGyVcjwe1XqQF/IJBhdetEOOcTqDsrG/ncFL7u
         MXX/s9DNoKSyZpXZTQE+pE+ECVAnDfLwrXThuNUV/HgJZfPtKrFwMfyPup5GaVa6fFyI
         BwKA==
X-Forwarded-Encrypted: i=1; AJvYcCUcDugPOp/5DPf6Uc2zfvDW3UHCwhwioTDV/a1xBq53cvb5G5PNwSq0U+ln0KDO9jzvlBg6hhcCKhOGI7CUmjDyPSNwHy5qoIU5
X-Gm-Message-State: AOJu0Yy7fF1F0SosfXeeOV2Yt0LexEle1mI+Ovde0ZlQxYPG+D7XGL5T
	01E+M5QlT98ohYKkY5mGcaxgTkaigB9cvZQuUsNod6+0sd1OHrghxGxJLMxYeCEs1ZpqUw0u82l
	NHl1IYSnpyI5W/p22kjLwTm/mfn4hsiXWHdGN
X-Google-Smtp-Source: AGHT+IEXsP4T2G6jGTP+d7kkEuiOFndfFglwLO/54VRu/s6qVyb4XmHsU+ChPOKu5pt1ZGfntquz6f6Y2H3XwDSmX3Q=
X-Received: by 2002:ad4:4eef:0:b0:690:2139:b50e with SMTP id
 dv15-20020ad44eef000000b006902139b50emr5804567qvb.18.1709677351705; Tue, 05
 Mar 2024 14:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUIlirG-ypudgpbK@debian> <20240303121454.16994-3-alx@kernel.org>
 <5882437.otsE0voPBg@nimes> <ZeRzS6mENO8kOh1W@debian> <CAJgzZor8TTSysM=TiTXQdVtHMZPQWu5YOhPmb8PAevdVd-c31Q@mail.gmail.com>
 <ZeZohz1sLcIN6kxA@debian> <CAJgzZoog1qS4BOYaKDnLsA3RzL-61r=33tP-XK2xvOwa008jJw@mail.gmail.com>
 <ZeZxSydsfskaQ5Vw@debian>
In-Reply-To: <ZeZxSydsfskaQ5Vw@debian>
From: enh <enh@google.com>
Date: Tue, 5 Mar 2024 14:22:20 -0800
Message-ID: <CAJgzZopTu=mQWcDGGHKnTRE3i+ksoLd37NwWg2fTaaGUkv9aFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration' rather
 than 'request'
To: Alejandro Colomar <alx@kernel.org>
Cc: Bruno Haible <bruno@clisp.org>, Stefan Puiu <stefan.puiu@gmail.com>, linux-man@vger.kernel.org, 
	GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 5:11=E2=80=AFPM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> On Mon, Mar 04, 2024 at 04:56:13PM -0800, enh wrote:
> > > > int clock_nanosleep(clockid_t __clock, int __flags, const struct
> > > > timespec* _Nonnull __time, struct timespec* _Nullable __remainder);
> > >
> > > Hmmmm, that's the best name, meaningfully, I think.  But I've been
> > > trying to avoid it.  I don't like using names of standard functions i=
n
> > > identifiers; it might confuse.  As an alternative, I thought of 't'.
> > > What do you think?
> >
> > as you can see, i've taken the "the leading `__` means we get to
> > trample whatever we like" approach :-)
> >
> > (we build bionic with hidden visibility and an explicit list of
> > symbols for the linker to export, so we'd have to be trying quite hard
> > to trip over ourselves.)
>
> Yeah, I was worried about the manual page  :)

yeah, i think "t + extra text" makes sense there. i just try to be as
brief as possible in the doc comments on the assumption that most
readers will be seeing them in IDE pop-ups, and anyone who wants lots
of text will click through to the man page anyway. and at that point
they're your problem :-)

> --
> <https://www.alejandro-colomar.es/>
> Looking for a remote C programming job at the moment.

