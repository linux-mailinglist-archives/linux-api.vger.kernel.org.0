Return-Path: <linux-api+bounces-4258-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF8BB14371
	for <lists+linux-api@lfdr.de>; Mon, 28 Jul 2025 22:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50287188D357
	for <lists+linux-api@lfdr.de>; Mon, 28 Jul 2025 20:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8ED279DAD;
	Mon, 28 Jul 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSajxShd"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB000277CA8
	for <linux-api@vger.kernel.org>; Mon, 28 Jul 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734887; cv=none; b=s98EF6NijpqPFyYIxsE+rqzU3zCuxajgN/0T+WldO/2pRoDD88jWYmNl15JDlvFLT6u19Oqu3u1Z0qTG3AmM96Sln1hRC7+wvRQN/dKkqvjptqAW4Qg0Xz6GinFvD9bqUr2MyYFd0pgrS/w0EbnF8M1t+iw9hNh6XScZ+gfbdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734887; c=relaxed/simple;
	bh=ZV232Dxo6P1lXxwl/8XNtSFqtMaix+T+IL0Z7bfuL8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQEt/JxdJbLX2XAecqcveO8znwbVvEompCGfo5znkuLVRyWQmqKWOVJWgZLydre5rQSNq/hhCn9jH91+SLeWLG5NqS4sx6IqIDC+WrHQAqAHTsLcfwtl2L2AL13r22dhuBveXYJfWQdIsScJNNJbdekCHYpOoJE1XIDVWH3pAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSajxShd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61548e5521bso597a12.1
        for <linux-api@vger.kernel.org>; Mon, 28 Jul 2025 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734883; x=1754339683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cIuEYX17XiPrfyxPlwLzcOeQJGvPzMkyLjuQxbOTNU=;
        b=KSajxShdG5yVJdFBlcGQgjV0xUzqxDtEezygy0iwGpLivmS4oDZn7SszGJmASwPgFg
         4tFlebsyL9c7mGvxsfTB96rpcJITlrJDQgCogJMMomQdXTj08QJ7VIKyDd+caw2vfVVz
         /SQyUB+R14dkK01wAR1+FEOr/DXuFX2RwhUY9IUpcrOJVGJgGQ+q6trXtoIxhRXhjajZ
         dkIgRDIq+p+mLTBOBcmi21K7sAk6GasXo+zWXPwacMBG1H7f+W3P0oorI2djA4DRcZ3B
         EltYGRsuaG9fTUbtbTIkqBl9azVCyaQWib7Qy4YjXKyWq8YmtWYWKFKqokicVaFqkAFn
         K4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734883; x=1754339683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cIuEYX17XiPrfyxPlwLzcOeQJGvPzMkyLjuQxbOTNU=;
        b=eakssUi8C1KsbiHgTbNQls49LZxgrD6+xU3TN3KoiVFBJWHJrqk8o7yF6h2fGZ8GG3
         hsXBaRQPhGrcAw7udjQmzHGNwuYQfJhgYbngLWTtRgyAgpmneissZVxqrE9C1ODs+q9T
         ND2fYiPa6b5Dx0m0sEMsIQEY5hAAW75eg1y3gOeSYyACkD7YGcJq132TluvOZ6h1RtUr
         oXbvab1ma+OwGIN58IDAIzgPOF/wTJgJnpnhdZJgbEcWdPSYDpiGSU2a4wBkpxT/sbGB
         9te0y8YijCIvwvR0Ec13oEjpeDyd4zs1GKZIi5DIipF0gaXBKPxHnJrtXKpXI2vCrbMJ
         kAFw==
X-Forwarded-Encrypted: i=1; AJvYcCWU11/oxiGnyBATK39GGtol4SuhtwaM+kW6FhPGKk+lJiLw4F/bpU+S9uWjhQqZIfyNP90ctwazZNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJlPhbn95Y4G2quk5UqZO2xgE8YKtC96hhvKHk/z6vJOqZ81Y
	MV8eKTBCtK+O76NF1bmU+o8lBQb9G84kAADtM9A5yXCMm7nFBp88sEhIja/GQzLCkV+SGRIgDBX
	dCSErnm6RIo/sBixrpAQQ3T9mpySpCb/Of4/Rutii
X-Gm-Gg: ASbGnct3JltT3G+xxinLIi4mhl4g84MMVLtTYpoiXt/iEadMVS+p3Vwy7mhZQWTWlEg
	o1dGV14+oy1R7LbFnH/LM0y8tx6et5sS/UBy9bEKFWUQ71yLRdCdimmg9jEDucT76mowMAGl2Pd
	jULVvVTt1iL1eGm2kQli/TGP5vUVeUN8U5vQ9b1Zlj69YZdHpiOZ/dfWwA1ayCjNDa0iHEOzTdO
	jHGsCKzyb8xVcTs74ZEvmTVrGwuLrA6VQ==
X-Google-Smtp-Source: AGHT+IGSwHNM1lMm6iRvrNhpLZM/44NLBcht7A9ZyhiiFAeshkQMQrkJ5OQp5Ak5DNIjWjjK+SMh7cZBKnKVJBMgOHw=
X-Received: by 2002:a05:6402:2291:b0:615:3301:25c3 with SMTP id
 4fb4d7f45d1cf-61567304ce8mr13512a12.6.1753734883112; Mon, 28 Jul 2025
 13:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753711160.git.lorenzo.stoakes@oracle.com> <386ba8fc99adb7c796d3fc5b867c581d0ad376c7.1753711160.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <386ba8fc99adb7c796d3fc5b867c581d0ad376c7.1753711160.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Jul 2025 22:34:07 +0200
X-Gm-Features: Ac12FXxZWrVG9lHiMIdLtQnur6MhrtrOas81mqHV8KcQZRHD1RU90YYt9ttm5Qw
Message-ID: <CAG48ez2rQfWJwnpAspNr8OtLXgPadG55Re0KoK5ovBKqE3AcbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] man/man2/mremap.2: describe multiple mapping move
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 4:05=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Document the new behaviour introduced in Linux 6.17 whereby it is now
> possible to move multiple mappings in a single operation, as long as the
> operation is purely a move, that is old_size is equal to new_size and
> MREMAP_FIXED is specified.
>
> To make things clearer, also describe this 'pure move' operation, before
> expanding upon it to describe the newly introduced behaviour.
>
> This change also explains the limitations of of this method and the
> possibility of partial failure.
>
> Finally, we pluralise language where it makes sense to so the documentati=
on
> does not contradict either this new capability nor the pre-existing edge
> case.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  man/man2/mremap.2 | 78 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 11 deletions(-)
>
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 2168ca728..cb3412591 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -25,18 +25,41 @@ moving it at the same time (controlled by the
>  argument and
>  the available virtual address space).
>  .P
> +Mappings can simply be moved by specifying equal

(Bikeshedding: This "simply" sounds weird to me. If you're trying to
define a "simple move" with this, the rest of this block is not very
specific about what exactly that is supposed to be. In my opinion,
"pure" would also be a nicer word than "simple" if you're looking for
an expression that means "a move that doesn't do other things".)

> +.I old_size
> +and
> +.I new_size
> +and specifying
> +.IR new_address ,
> +see the description of
> +.B MREMAP_FIXED
> +below.
> +Since Linux 6.17,
> +while
> +.I old_address
> +must reside within a mapping,
> +.I old_size
> +may span multiple mappings
> +which do not have to be
> +adjacent to one another.
> +.P
> +If the operation is not a simple move
> +then
> +.I old_size
> +must span only a single mapping.

I'm reading between the lines that "simple move" is supposed to mean
"the size is not changing and MREMAP_DONTUNMAP is not set", which then
implies that in order to actually make anything happen, MREMAP_FIXED
must be specified?

> +.P
>  .I old_address
> -is the old address of the virtual memory block that you
> -want to expand (or shrink).
> +is the old address of the first virtual memory block that you
> +want to expand, shrink, and/or move.
>  Note that
>  .I old_address
>  has to be page aligned.
>  .I old_size
> -is the old size of the
> -virtual memory block.
> +is the size of the range containing
> +virtual memory blocks to be manipulated.
>  .I new_size
>  is the requested size of the
> -virtual memory block after the resize.
> +virtual memory blocks after the resize.
>  An optional fifth argument,
>  .IR new_address ,
>  may be provided; see the description of
> @@ -105,13 +128,43 @@ If
>  is specified, then
>  .B MREMAP_MAYMOVE
>  must also be specified.
> +.IP
> +Since Linux 6.17,
> +if
> +.I old_size
> +is equal to
> +.I new_size
> +and
> +.B MREMAP_FIXED
> +is specified, then
> +.I old_size
> +may span beyond the mapping in which
> +.I old_address
> +resides.
> +In this case,
> +gaps between mappings in the original range
> +are maintained in the new range.
> +The whole operation is performed atomically
> +unless an error arises,
> +in which case the operation may be partially
> +completed,
> +that is,
> +some mappings may be moved and others not.

This is much clearer to me.

