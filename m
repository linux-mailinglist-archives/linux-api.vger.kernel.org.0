Return-Path: <linux-api+bounces-1636-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495E8D1C2D
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 15:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F6B1C220AE
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD416DEA1;
	Tue, 28 May 2024 13:08:22 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA116415;
	Tue, 28 May 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901702; cv=none; b=SzTvujzwQpYZBQ57pDJqCASofiXEyvFE17ohu1fAZutbaqXWztHk/gQCFaBEEtloDQ50HEo4g0DaWaWzZ7eHcXtM0HIpnhi9CUrCr2xmDwNO/t9ZfNczjGBI7w0OEmwwh9O13tGwfbWV7MuKEmm2s/YZ2AjTQvzdGzzSPxfDAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901702; c=relaxed/simple;
	bh=FL/IHmb6BMmy3C8suNCmO3xRrM+w266zhUsBJ/Wh0OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPkfmOgg6Pz3FyoX2zADAL8gzw8/vzt3pUP5KWi0/yvX8SDF6ZPPobUKzy9S1zGGVzAWn1V3oQHio2QPp1QEQSZRT2rZ6AaCyTz1fsEmzbFHfGIS3EmxdYmosUTsnXuAke9hKnisMNGKCnVDbtP63j4Ykmi3Kvq9RdHaF/SHh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295d509178so1036010e87.1;
        Tue, 28 May 2024 06:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901697; x=1717506497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ADNlLgF6T2svAn5d+KaQRdOL4An/XIqcqDrDRQoRSA=;
        b=e2pzkVLf3iWU9sfNmK1PDZw60LPz9ru9dNWglc0Q9hMDBUyo+PI1LfQamszyuKxBHq
         eRY6fjEjXUGTk1dMIV/dc7R7GtJYHSHtW1VUrUo/tEgCPdaVwpBUNHgJtgNz6CeWXOos
         Mt17wCvpZQ310q9qkDh8taJKz5nawt21WEipHasF5T+8Q08cjYRJbur9oKKT+EIgve99
         /Ph5vUz59nLbCSNP2zpxEODPs9x6/4zXDZ9vIqQhxTOUY0XlGbX4d+J/oB6FxH+MDg0S
         K/YQ+cs+jPrTmVEP4DjVksJiPwbpb6C4rTsFtH7DD8L47pfMnd4cLzwNlDxEFY+8fuUK
         7uvw==
X-Forwarded-Encrypted: i=1; AJvYcCUtoIg4Qw9fvg5DM+OproDMn1fQfKpX+FrDPlSkoI26TN/3k3UnEqua9vngikfeCW/nBtrNG9t1sXG3VG1h8UEWLUVHEgT5e9PluJg5Cwsp1Ho9ExvOD+JrkTVTXSKQzQCY2YeFB6/K
X-Gm-Message-State: AOJu0YzsxdWcPEjSS3Ts15CDOF308L6ZNtUTiITYYwc24xqG8cJ5FSGO
	1A41Lgu72Qb20UH9c8NMv3YSZ7KCDJ4BPeZNb6uoESugfzymUUtQEGI8JCOv0qw=
X-Google-Smtp-Source: AGHT+IEMEMR7er2t3ZdTZkc/bBwHOGn/bwFIRyV/uphxUQXimv7ndNd4y5W7Ol9E4bSqqVn7RoJlAw==
X-Received: by 2002:a05:6512:3b91:b0:529:b023:6b9d with SMTP id 2adb3069b0e04-529b0236c66mr6982204e87.16.1716901696896;
        Tue, 28 May 2024 06:08:16 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529b71cd9bfsm410416e87.128.2024.05.28.06.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 06:08:15 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so10166281fa.0;
        Tue, 28 May 2024 06:08:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWE5Divj3u8cJtLB6wg7GAsNbHfZqdNUXMxQIxtAgaDJqKIg2NWB8QMjtUe/HyUswppznmCowe7HHVyrKnmIcrJ7sKjoGv8ICPM8lCGbFwVqGAfR3j/sKnG6iXK3Fa4ykDIB5sRyUYA
X-Received: by 2002:a05:651c:1992:b0:2e7:1e4a:31d3 with SMTP id
 38308e7fff4ca-2e95b097761mr137091911fa.16.1716901695021; Tue, 28 May 2024
 06:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-4-Jason@zx2c4.com>
In-Reply-To: <20240528122352.2485958-4-Jason@zx2c4.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 May 2024 15:08:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJ8KpaqnWeHCMbJdf-Am6uY0N+uFM+OVxWTZH37TQvxw@mail.gmail.com>
Message-ID: <CAMuHMdVJ8KpaqnWeHCMbJdf-Am6uY0N+uFM+OVxWTZH37TQvxw@mail.gmail.com>
Subject: Re: [PATCH v16 3/5] arch: allocate vgetrandom_alloc() syscall number
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Tue, May 28, 2024 at 2:24=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> Add vgetrandom_alloc() as syscall 462 (or 572 on alpha) by adding it to
> all of the various syscall.tbl and unistd.h files.
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

As of commit ff388fe5c481d39c ("mseal: wire up mseal syscall") in
v6.10-rc1, 462 is already taken.

v17 ++ ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

