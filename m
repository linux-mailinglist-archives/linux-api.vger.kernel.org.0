Return-Path: <linux-api+bounces-1570-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC118CB3F2
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2024 21:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3831C21D8A
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2024 19:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF242147C9F;
	Tue, 21 May 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ht+jIFBk"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2769DF7
	for <linux-api@vger.kernel.org>; Tue, 21 May 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318103; cv=none; b=TIuhn75A9xuvycQqpc3kxGxgDsqfMQsc4mLbFm/TPMelMdY8fKqI1vQc7pHj2lrYCX+xQPq9RzkxiOyCts1zuA4qm5kyXrNtPMmkkw7QsvliItXje6Ex9/e2qHI8FBWlyHvkRwnLMRAWzRrhuyG+r5m+GzLvqHq2fdbq9JhRbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318103; c=relaxed/simple;
	bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuJcKrTeUyXbJNkazKuqnBJNOPuGn3i/YQSuEQQ4UyPMM7ZeDNCMMhZLPiNh+xIdedO1livBsnzLWRolcxON4JmLZQRz3M1QwzDt3MF9JO3KYb2mnl2X6dgYI+rqf7EHiGnEEs+2CFN2tCtDL/82xwsnT0cOA9GcioS2kwAoEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ht+jIFBk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so2670a12.0
        for <linux-api@vger.kernel.org>; Tue, 21 May 2024 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716318100; x=1716922900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
        b=Ht+jIFBk3cNQ4LouwQ98RYvh7hB2eYM2ZbgCefBqRQRo0b01KQfg+wFBUHu50gKV5g
         wF41rDN07fNTqVHWvgbrAm7X3Y1gxjlW6PEbfBvkn7sytcQCC4zifIaBpcZYwXE+BfXC
         03cGODrOk5d3Xp5xy9vrhkZ9JO5ZDto0cs5LjTZvX/sIjssCHFEefC5xFH4/tXLb1eS0
         RnnVFHyYbrDpsoI43e2NPliiwFhSvW+LDdV6/Otk5AygJ2YOD6P7E4ZdhziJcQOV75Sa
         FOMD7a3jLAvoGNte0WvnFr3I95fA2vo8spEeNxI7LuZXmBlly1j0Jr//v4cYm7K5m6kb
         PICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318100; x=1716922900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
        b=VG/2zp+G1qGKUfRkLV3ddEcGg0nQxsImHQW4tHnz+vKrsmG9HzPl7/SZeY5S9FlnvL
         y4mgHenWVkTqlxlFYASNO+hnPnMvbT0GbwG7lZUB942lvqpacb7DocLS2zdrf8zygly3
         pV8HR5DZDx3IyUYG24rT3mvO8/wZtORqN8bXpdd8EMsAteD2dQ7B94OEXWGYzwxvJsZH
         Px84e7afOwyU/znvErBCEn5OTcu786b/FUSUS0g0ypddQAr0UPaLpxMJm3l59SfyNYhQ
         qS2tBwNYCdC1nJpfTSM9LoQF9VF2HGaOlDQ6lpdEVd9Fs+lxIjfF0tUN2rC960+u/2E0
         QBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNpZ8CqlFJiLmSqqZJFOf0yhrPdCsxfEdqdoBH1GqGoShjSNNczlt8nT3zoNGRy0xa+LNxLBwx6LE5ezcgazMMp6tpqpHc7q0U
X-Gm-Message-State: AOJu0YxQectvZBXxZbHVYkHlQk8L/Oja30EYJB5kp+v34wEeakB8B2JQ
	i8yR23Z/mT45iERrrnSb3cRW/SutVXS2n2D3LSeDgK/2IYZ3Ux/CdohQ6BjjC3L5AkNK9ShjhKS
	bf0buDIqNgiPpqsQmIjuAa5gzNkHkZ9UNlnu9
X-Google-Smtp-Source: AGHT+IGsZHMYwB17/rHm2GPw8sDf3nKxTSkcIsaApOp5bux/QDPAPBCrzCKud52Dm0FNps4wM/XTSDtjC7pz3lXd3Qs=
X-Received: by 2002:a05:6402:3594:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-5782fc1d68amr18531a12.4.1716318100237; Tue, 21 May 2024
 12:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427112451.1609471-1-stsp2@yandex.ru>
In-Reply-To: <20240427112451.1609471-1-stsp2@yandex.ru>
From: Jann Horn <jannh@google.com>
Date: Tue, 21 May 2024 21:01:02 +0200
Message-ID: <CAG48ez0rOch3wemsmrL-ocadG1YeJ6Lyhz1uLxJod22Unbb_GA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 1:24=E2=80=AFPM Stas Sergeev <stsp2@yandex.ru> wrot=
e:
> This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall=
.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLO=
W
> flag. This allows the process to pre-open some dirs and switch eUID
> (and other UIDs/GIDs) to the less-privileged user, while still retaining
> the possibility to open/create files within the pre-opened directory set.

As Andy Lutomirski mentioned before, Linux already has Landlock
(https://docs.kernel.org/userspace-api/landlock.html) for unprivileged
filesystem sandboxing. What benefits does OA2_CRED_INHERIT have
compared to Landlock?

