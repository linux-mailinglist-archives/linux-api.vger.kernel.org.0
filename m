Return-Path: <linux-api+bounces-1943-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9192EF81
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 21:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32EF1C227F7
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60516EB7B;
	Thu, 11 Jul 2024 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MkPRDx/k"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117216D4D0
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725482; cv=none; b=Yrpz52IjE8EaqSNcsIrU83r2Uxd2ZkblAZp0Tgr+GHf6A+B/u2wSMMCWTIBZkVS5mEfN39vyU3OVw3yQbnDMKWZpsU+e8orWsOZ56qYEd2WigwS9naFBZSES61MA0pRJ51nYUoShraq0dnTP+TdY3fzsAyZrcKJgz4TOLowJ0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725482; c=relaxed/simple;
	bh=jml2mH5xPX6WLHw6QUqvLqc4gm8iBoTV1e8ILzGXDOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFaMIb3KjcKd4nHEYr0Px6X5Q7Cymmq3EHVGuoetJJZYy++WDVqmDiB0dGvYB6i4bI+Zyh8srdcN6RUDBdhUzKyyWC071lTtBg//a1cpoLjKuUP54Y1l9Cjp3w01ZscfwUpvUjnU2H6iUe5AA94HYK8zVFUYRXqnIfgUquoFoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MkPRDx/k; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-595856e2332so1601243a12.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720725479; x=1721330279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PfkbCy6IC8MM2ShGGRIr/7yv5osfVo7ephGJ4Ll7hD8=;
        b=MkPRDx/kFwn4hGGIvnRCaSXjxeQKiUuula4Ro4MnbS85ZiMTAPEwVp1ZGgoUGY9p6C
         bajhlH/kOA4+4E4ulKinDdHSObwkkCwg9mmf2UXyelPB8BFzCBCzmWT1uE4Iors5jc2u
         olwpRth0BAKv15KJVd2bRZjrmYMz+9QrMAxr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725479; x=1721330279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfkbCy6IC8MM2ShGGRIr/7yv5osfVo7ephGJ4Ll7hD8=;
        b=svRkjYnv5G+7+Gogec+72tNwFIFBf0vipp6A/vqanDk6tROZ+yH8MqFtEX3XBKdv/H
         Vgrbe14T+RWc+BVYl9LrF+gPvbJ87ccJ0uVTkjEv+jm4vX4uOwJbNhL3ziJCmRKUu7yK
         UOVIOJCA0oubZ3bxoyb3Xmnle59rBhjMI1x4Gt8xli0h92qy5phNWHTmUPJmfPnqT42U
         UYi0fmRUFRH4JC3e5EvTFSDepGCUr/rdLdUfdpWAa7EmR7yzA3GLiK1o8JRaSv9QB04P
         8UfeW4e8VvDgzQg2y/koa/qXCzzMf5Bi3OpbVAsMiBnhUIS3H9y958YuRl78WTVimtYu
         GLxg==
X-Forwarded-Encrypted: i=1; AJvYcCUL34gV7QbIDmncuWpVt2qC6GMCBc52uzJzs0wZkq4g+5IkV5b8mjF9MSJD5GZAk5kFO6AP7UtUFk8Kmj+63UdsXYlLfgMqVvBB
X-Gm-Message-State: AOJu0YzfPq/cMCgVHjJU8FdaKti7+VF/ZDTlwydrD9rt0VSrLOOguxob
	f5NieGCQDaVFAr8sBIEylN2qzS60PEQ6DvzP8U32Lzhx0k23KlFwhkDqLYiZfBkKh06Dicx/CZ5
	/ExIp8Q==
X-Google-Smtp-Source: AGHT+IFi4sbxd1PD2uMXo5S5D9rzM7AbBiZsXWlcfc6qV/SiX+Npy8G7qu0KzsGkwUw/az7rzCnf4w==
X-Received: by 2002:a05:6402:4408:b0:58c:ccc1:17ec with SMTP id 4fb4d7f45d1cf-594baf9110amr7439545a12.13.1720725478773;
        Thu, 11 Jul 2024 12:17:58 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-595b1c0c869sm2938004a12.30.2024.07.11.12.17.57
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:17:57 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso1732921a12.0
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 12:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtAD/cyRif3p0rgvPrlVptq8yZeaYEQpqAAixxjxBOg61/eO0dExDjv2y6rQr6JnEQ0vpa5Y1MblizlWLK5w8DhDPIDpqnxTtx
X-Received: by 2002:a05:6402:2707:b0:57d:10c:6c40 with SMTP id
 4fb4d7f45d1cf-594ba98e3c7mr6937905a12.7.1720725476855; Thu, 11 Jul 2024
 12:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709130513.98102-1-Jason@zx2c4.com> <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com> <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com> <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
 <37da7835-0d76-463e-b074-455e405b138b@redhat.com>
In-Reply-To: <37da7835-0d76-463e-b074-455e405b138b@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jul 2024 12:17:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVc6cpSCJwAqrhPvwBbcQEOL2TEnCELfadhA=n1GN4Ww@mail.gmail.com>
Message-ID: <CAHk-=wjVc6cpSCJwAqrhPvwBbcQEOL2TEnCELfadhA=n1GN4Ww@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 12:08, David Hildenbrand <david@redhat.com> wrote:
>
> We also have these folio_mark_dirty() calls, for example in
> unpin_user_pages_dirty_lock(). Hm ... so preventing the folio from
> getting dirtied is likely shaky.

I do wonder if we should just disallow page pinning for these pages
entirely. When the page can get replaced by zeroes at any time,
pinning it doesn't make much sense.

Except we do have that whole "fast" case that intentionally doesn't
take locks and doesn't have a vma. Darn.

             Linus

