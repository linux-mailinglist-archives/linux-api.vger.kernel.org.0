Return-Path: <linux-api+bounces-5102-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 510D1BD293C
	for <lists+linux-api@lfdr.de>; Mon, 13 Oct 2025 12:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 993DC4F03F9
	for <lists+linux-api@lfdr.de>; Mon, 13 Oct 2025 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA842FF17D;
	Mon, 13 Oct 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIQhb/oU"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32112FF170
	for <linux-api@vger.kernel.org>; Mon, 13 Oct 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351386; cv=none; b=onsmvLJO1FhDcBuJQ6KREuGgQA5Kv3x5w9WzhKzLgm5YanxJLEN6rOxFDj1lEtYsddS1qJnqFj2X2dzBVUIPKLa4sWefZ807sFGoaNfJtjUMN5I3ix79EtcrI+TIGkt/tGscYOi2lxHGynbyMvHWyzbxZTgCJ2yEk9CA7WtzPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351386; c=relaxed/simple;
	bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMPEr+Ybd5Sb6a3aZjQyD04bXhejibpwnY1WtChMDasoNtKaLJUSvo255r0ehdACMz16x5r04hoZYnYwLH5nh0IEbv/7/T2y8M5IME1FPxrrSOLpen0a2GRa7YGv7SHB/ySKympkBz6zcrN1rnYguF/+A/KraN+ArHn0zHBUNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIQhb/oU; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6353ff1a78dso3712811d50.0
        for <linux-api@vger.kernel.org>; Mon, 13 Oct 2025 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760351384; x=1760956184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=ZIQhb/oUlO3F9MEPUxurf/mgWI7Y1g8uHfT6SNbxuv/4xY5+m/YraZW/5KqmjRIwzX
         rdTRUXUR5ZYcRqHAcjEXbyqp9QPzrQjcU/+tE2lLY7zsYf9eKvPgMh7Yb+eG+DeMYl1A
         NNkv7u+ELQLfd91UVqU5n/EDVbx6VQywzqTdWGNVo8cwyfdUj0VZFPUXp9En5uePFJsJ
         B8tJ7rKH5YlpW+Pq8nGhj+PB2fjPaXocpEbEosY0ETAXl+QzWKYisCRZclqHs3mpy0wb
         S17h9fT1i/DEuznIcB2PXT67kVi/TGa5zjTd/jM4v9YckG+ajQAB0eFRwEULsu95liHd
         eM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760351384; x=1760956184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=qqi/IFAqqJHQZbEhd1JF+hj4dLI9g/AZUq99M7BdQKwPe9QUNP7EOg9ac/PSzyD/Nv
         SVAG6ey5AY10TGW9Fffid3/yqbYKh4RE8TjwdPl7etagzXOyKUFXUT/31C8Q84XheclV
         a071j7I/A0aVbHrx+wC8b3W+XNe6GuFVtCtGkUSpvgl+iNTZfzB6FKBBSRdH3hseA+qc
         oFXkrWeTpu2u5JhCUA0b55EuU1oFJbqxCyJEb1cXkSx8jBaApYI/LKSB6HcwCg0YjfD3
         s33X/BZOLDLSYPCXyvnU4zr7ARoZE6YbcvTMEcgrgskdqasir96ebqgouaJD9HEmXaYP
         JMng==
X-Forwarded-Encrypted: i=1; AJvYcCUhP4G51Q8tq9sDxJPFAnPEGSxK+EO5+tDphDEHyIxIyyw3N/OYo5cwVgY6UK3YT5x9pOaz4QUZMpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvJjnfaLWKOI9jGTMgF5DdtufaZkAzHsycvZQgKHXKrv5tCUB
	YPMtnAfl6/wvVdXDlm2sb9oPb7a4yk8p2UIMHeNIvyWinBR/+CIHWnIGj/a3yxgU6nIpnLJyBvx
	+ba1W1PCrUWIu7T+i54XR7vvf1iNMoe8=
X-Gm-Gg: ASbGncsgGAwKimgYfo23G1dBouCmdEpVr/2dGhO4xGn46wEqW8ADdG12Li+bXz9XR3N
	GYgqMpweyBV5bsQrfN5+b5/+BzVMzyEyoMt0P6Nr4eaf0VjeGFjUgfxHRcVoXw//NJpOS9FkAQw
	Zuors3CdmR0+0MU9hiECLkTT3ySWPWrIoBroS1oWgialNEXDCKBJic6tpNigZhOXodyd4dnmNrG
	l9UvkA0JYWd/7QYt/z+hS7qxiJRwA/fYgSi
X-Google-Smtp-Source: AGHT+IF7gB/uIYJ4y7t+OLiZ00mCO9lllMt+QoIyqpZ385m2NgZqSy+lqlMIQpqL29tGtjodZ9h+RUr8WRjGSui6l/0=
X-Received: by 2002:a05:690e:4186:b0:63c:f5a6:f2f0 with SMTP id
 956f58d0204a3-63cf5a7080fmr6997775d50.66.1760351383745; Mon, 13 Oct 2025
 03:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-3-safinaskar@gmail.com> <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
In-Reply-To: <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 13:29:07 +0300
X-Gm-Features: AS18NWAYGkNu7BjeCT0jHGno_eA5ARoSWF2j7yYdLIuVOnrJP74yF3CsWnjM_B4
Message-ID: <CAPnZJGDe+sDCsCngHyF6+=3=A9pYwQ1+N87jpq-ZdsSvVbQuNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:31=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> There are more places in Documentation/ that refer to "linuxrc".
> Should those also be removed or fixed?
>
> accounting/delay-accounting.rst
> admin-guide/initrd.rst
> driver-api/early-userspace/early_userspace_support.rst
> power/swsusp-dmcrypt.rst
> translations/zh_CN/accounting/delay-accounting.rst

Yes, they should be removed.
I made this patchset minimal to be sure it is easy to revert.
I will remove these linuxrc mentions in cleanup patchset.

--=20
Askar Safin

