Return-Path: <linux-api+bounces-4244-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A0FB124A0
	for <lists+linux-api@lfdr.de>; Fri, 25 Jul 2025 21:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7381700B7
	for <lists+linux-api@lfdr.de>; Fri, 25 Jul 2025 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617B25A2BB;
	Fri, 25 Jul 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnS9beiT"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E2257AD1
	for <linux-api@vger.kernel.org>; Fri, 25 Jul 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470667; cv=none; b=tftYwu98ip/RAVwzhjGCfg6JOfuElpyZQa/oOCOhO5i23rlHz6TlSSfQCdGYmqRws17a5RJ8BBrRoONrFGaa8zq4NtZIBwv3/fsq6C3DHXF3WleD40c+cMslle+1kfD+VOteg/qnXXnu27ivCuqX4ikVrVR6WUvKu27dd8Frj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470667; c=relaxed/simple;
	bh=ohbQ5KF8b/EeqfVu3tRLb4Pn8KVgHa3I47YPvi58yJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS9uchHFfT9fmgiqWIZGqKYIMs0omDoin8HFRUZAPGJ5MFc2pzq8JHGIJaroSSsMKLttAOulgBexJWHsaw2SboVrLxmv4r+3cAYlz/Qkj4+3p6khSiYPOnqUtTml01O5nWnOFTcT9UoTFntj7zDAcV83K1gbFli3sDm1bmzg6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnS9beiT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1702a12.1
        for <linux-api@vger.kernel.org>; Fri, 25 Jul 2025 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753470662; x=1754075462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohbQ5KF8b/EeqfVu3tRLb4Pn8KVgHa3I47YPvi58yJM=;
        b=DnS9beiT7uXsPw3bRisI+ErVdWds8WtJYyqV1d5E2WN2ZE0H2wuraqH+6Dl88gV9Nx
         IqqgSxSFfnH1JEtdCymc9KolcD+WMl9AOtqvqx+sLOAS5P7FxKyHPltmWPOtq+VIvnpC
         D8HlKLGnF3KG9cEcP3MbZrtG6WtdQTdF4FwHrV7rGNvGJvRZwUJcVQYuBrKswmlivJSI
         p4U7orPNmLOGN88jwxyzKOss11JcJBKZgTvRnYmDX3mpvRtHJCaYHfxfwG3Sws5gNekF
         dswdqL0KSeD08UVsbSFKzLgtR60KvO5BYuvUoCDiLHJwTc6tTZJb4bQIfpKNrTBEfugc
         IFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470662; x=1754075462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohbQ5KF8b/EeqfVu3tRLb4Pn8KVgHa3I47YPvi58yJM=;
        b=LqJJ1MfgNIkvYNbPbE5wvX+SBSFnSwu7u3RkzIDJa7bak1RAshbTWYenxB36j/q+aO
         5b4ljPSfhPdxRpRalHWBxAWy+X+wBTWFTrC6zCIh20c3BOCr7SUdVSxoSDwFDfG77GKI
         MlotuG/1UqvoA578qx7R1uJMTGcw7ivIT+ziRAKqVOtGEMOdhbKoNPGH20b3j4ho5dKH
         zRWnOB4rIOoe1nMjr5TDtmXd0IGIbKTMkskAZ9Uo8sEi68UqxIgsKxjepf9NfyA7OJnm
         G6QFaA+BNSzwGvjBZ/VimP2bFGqZ3ObJlnc5ZYXRfrafCKn4Z4sTFuLonX5lwixJmkN8
         XJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxOT0b48MzUe0qkGImhdP27T422KDugGdaoq44PeE5c68lsR4OhNO+3fCSS08oPRNGa4ictKmzWHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk7bYp1BSenQjEOG2sXeu5Yo25I1l6G1DdUhZSpIipMU6uZJKV
	IlTM2N+fRq+wFOdWnhFvuJXNZzJYELUVvgd7I6uHWWHtOP2ygHFr8zmZ8ymoC2xXJ9nP1VJw3vC
	2BgiR2zh3a1zC+gVuHUbxJ9C/dmiMo2PorFQOjWV2
X-Gm-Gg: ASbGnctaatoPGWMwXigoRgVf9XJxF7IzhhZgFabWJRed1OjXtc3EA6Ft3EX5r8jSo1O
	8aAy2MDyG/+V8MEZKMAL3Y0aqMFRWVswmzFjbF+qkmHzkVhzHA9O7ALiNZzXDVaBHiBT1vAh6ZE
	3WmYoYRaQ58J2Nto7L1aUiBTsCs41qtzHBwGrLTabdt/MWcFR2TGQAktXOJ59Is3y44TpDLQ+kW
	RF2rUj2p9Mh+kCrddx1Pr2GCTMSMRDfG54=
X-Google-Smtp-Source: AGHT+IFnM9lb8v0yhy+r9g7LlejQ85g1+jN80aPjt0EXGFDmgpf5XaZMiO20Q6d8dkFVzoj7t44+LzAH3gV+dXXjqTY=
X-Received: by 2002:a05:6402:2088:b0:607:bd2:4757 with SMTP id
 4fb4d7f45d1cf-61505ca9e53mr18025a12.1.1753470661523; Fri, 25 Jul 2025
 12:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
 <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com> <892e3e49-dbcd-4c1f-9966-c004d63f52df@lucifer.local>
In-Reply-To: <892e3e49-dbcd-4c1f-9966-c004d63f52df@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 21:10:25 +0200
X-Gm-Features: Ac12FXzH0kaDd1FSHQ6rjBvK5l93OfpQZvkg8iFQz3nK0xtBEz9RE_fXG7JCCE8
Message-ID: <CAG48ez3qB7W3JqjrkkQ3SRdQNza3Q9noqkgmBg=3F_8vhwQ4gQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:28=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Jul 25, 2025 at 07:11:49PM +0200, Jann Horn wrote:
> > On Fri, Jul 11, 2025 at 1:38=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > Note that any failures encountered will result in a partial move. Sin=
ce an
> > > mremap() can fail at any time, this might result in only some of the =
VMAs
> > > being moved.
> > >
> > > Note that failures are very rare and typically require an out of a me=
mory
> > > condition or a mapping limit condition to be hit, assuming the VMAs b=
eing
> > > moved are valid.
> >
> > Hrm. So if userspace tries to move a series of VMAs with mremap(), and
> > the operation fails, and userspace assumes the old syscall semantics,
> > userspace could assume that its memory is still at the old address,
> > when that's actually not true; and if userspace tries to access it
> > there, userspace UAF happens?
>
> At 6pm on the last day of the cycle? :) dude :) this long week gets ever
> longer...

To be clear, I very much do not expect you to instantly reply to
random patch review mail I send you late on a Friday evening. :P

> Otherwise for mapping limit we likely hit it right away. I moved all the
> checks up front for standard VMA/param errors.

Ah, I missed that part.

