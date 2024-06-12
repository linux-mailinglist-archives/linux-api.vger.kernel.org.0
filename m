Return-Path: <linux-api+bounces-1732-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD51905E0C
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 23:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5384428600F
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 21:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2574127B62;
	Wed, 12 Jun 2024 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Szo8MSB4"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F68526C
	for <linux-api@vger.kernel.org>; Wed, 12 Jun 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229297; cv=none; b=gClxj1cbomp7X4mXiEuNBxGeeMZxdxD0K1D5AQy51vqaJqc0W0D45r5Bkroav4loobqDluqguWvI8DSBxB1vJAPnXG++SC9CPjw7amT9qVhj9aKm4452j3En749G0ZZcnTReJIMiDzlXjUNVk7rZUek3CHIBSZaaqitbFp91DEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229297; c=relaxed/simple;
	bh=j+5KelaD/4KELpEe6q0DQCGWyXRXbSSnxQxKsvvWrR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN9RzVxoL0+hEBCkcu/4XbqqJ7rbMphCHjRAQH5FkOmgyWAKDyJYblsIzVFcQS4ShbLoi5jTOgHZu6gI57ciMm2rnixoWHacXOU9c9vCJra0w+nGj6fzVymVwDVKZJLaBBRTfpvKCpMZ/oe7zXKynXmxPnzTLvL7TvkdZgrzFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Szo8MSB4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6aedd5167d1so1710156d6.1
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2024 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718229295; x=1718834095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0niQXskQ/wT+JZAsg2ie0yp0nVNXepGBuevZDm3X/6I=;
        b=Szo8MSB4hUUzVEu9I8Dc4FOWuHDxBdIEvFC+FhkZkEC3CiT8XqByurI+pNxtPJl4hS
         J489K495MuC4DW9aQDS8cU0kEr0pO0YT41ZY/W6hCAJJ2SD/4mkGpmEu1ZFbgvqM/PRq
         q9lQyzQfsEm2QdnOuRFuAeSsORH8Li3k2Yk48nsjSbhVdXZotbaHkDHYpx0hrmZbAJGb
         x4W1qELr7Q3yW6rGbv6ye9tm+K+bH/PgNV3oVe6u+QM3QjUKU56anOfhdalil9ZTEjD/
         32VSXNV5k1d4wC0XtLwtzFsRtYbO624esdXnmcWShNnCQk1Je6IaBizsujGuVyUeA0zE
         9Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718229295; x=1718834095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0niQXskQ/wT+JZAsg2ie0yp0nVNXepGBuevZDm3X/6I=;
        b=i6EOZ+Z0F97Ck6/Z9YkPDlDcQ52+Ae+WWbk+OeeC6A4stNjQ+QbhuKyF79bfq71MMN
         N7aPKA5dWnYy1XvY2CEbzfUWsW4m1Cep85P39zQlEknQSSRjK92n2Kt9nVDpTXXordZo
         5QVmQgNNtp9+jJ+yCVG50OOaTtQ9L4spZ7nvQvEI9VNh1mvnxVxTUFQZDEac/s5E9GED
         stmBHn56JQ6W8/eju2Ej1Op4Qx/dXe8yJenCSXp/zGG/rNqjrAPylnNsFjRLD1Ezuuet
         6FoMIjplKLQnbroCg6b2p58HEe121M9IrkSXYsHnB9y7FhzbalIuFlGqh3N3SjpnCrt1
         L3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUrBLpVxlloleZylWh1zEnRmYEmNQ7IvC/QrJH1qQXOPKv4DaxbmTN4hbftUJ6o2OuH2lrFbaIeLGEVYsZ+I8+Dm3x963IQcGzf
X-Gm-Message-State: AOJu0YwcHk8Pclm1VFrmHEwTZy133ctoP/ZMwQHcc5bI069BObYiXFWd
	+xt62juedvEJZaL+TXrAsdtJRAjaA43ZMROT8r0YBO69uArhx5MWLEcxJG8ez7ooy0d+jaVM16R
	VXksdaubSclBaOyhijLAudFM95POurobQiFEZ
X-Google-Smtp-Source: AGHT+IHG2n4kSZQnL7JamAKSLlJC5ZGJuNHEiaj/X9WnydQDgcR0qoCO3uoxx8DVbFaUJpsGgKTe9s6ylUcRYkBQY0A=
X-Received: by 2002:a05:6214:3202:b0:6b0:65dd:a241 with SMTP id
 6a1803df08f44-6b19196d8camr37904236d6.18.1718229295140; Wed, 12 Jun 2024
 14:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu> <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
 <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com> <5rfohnr4rs3tkfs7y3f7rth36c67pvcwv4q52onrjohdjtpo7m@stvcsncq7z4f>
In-Reply-To: <5rfohnr4rs3tkfs7y3f7rth36c67pvcwv4q52onrjohdjtpo7m@stvcsncq7z4f>
From: enh <enh@google.com>
Date: Wed, 12 Jun 2024 17:54:43 -0400
Message-ID: <CAJgzZorzcAP5wNa-UCMyarmjgwVBveg0c0Dj36ByVEacnOHrnw@mail.gmail.com>
Subject: Re: termios constants should be unsigned
To: Alejandro Colomar <alx@kernel.org>
Cc: Paul Eggert <eggert@cs.ucla.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, libc-alpha@sourceware.org, 
	linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:01=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> On Wed, Jun 12, 2024 at 01:47:03PM GMT, enh wrote:
> > hacked these changes into AOSP, and it did break one bit of existing
> > code that was already working around the sign differences --- this
> > warning was enabled but the code had a cast to make the _other_ side
> > of the comparison signed (rather than make this side of the comparison
> > unsigned).
>
> BTW, that seems to be a bogus way to workaround this; the cast should
> have been on the other side.  I'd say whoever maintains that code should
> probably fix that to use unsigned types.

indeed. i've already sent out such a change :-)

>  These constants are meant to
> be 'tcflag_t', so a cast should be to that type, or the type of the
> other side of the comparison, but casting to 'int' just for silencing a
> waring seems nuts.

i suspect the reasoning was one of readability --- keeping the [short]
constants legible at the cost of making the expression slightly
longer.

> This makes me wonder if breaking _those_ users could be a good thing...

like Paul Eggert said somewhere else today --- only if we're finding
real bugs. and so far we're not.

it's like the warn_unused_result argument. a purist would argue that
every function should have that annotation, because you should always
check for errors, and if you're not already doing so, your code is
already broken. whereas a pragmatist would argue that most people are
just going to add the "shut up, compiler" cast (or disable the warning
entirely) if their already-working code suddenly starts spamming
warnings next time they build it.

while my bar for that might not be as high as my bar for ABI breakage,
my source compatibility bar is still pretty high. it would be almost
unethical of me to make app developers do random busywork. i have to
be pretty confident (as with, say, "you just passed an fd > 1024 to an
fd_set function/macro and thus corrupted memory") that their code is
_definitely_ wrong. (and even there, that's going to have to be a
runtime check!)

> --
> <https://www.alejandro-colomar.es/>

