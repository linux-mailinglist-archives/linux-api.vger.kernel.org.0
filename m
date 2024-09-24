Return-Path: <linux-api+bounces-2332-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B953984633
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 14:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFBC281A08
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7931A4F04;
	Tue, 24 Sep 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAnMo7i/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFAF1A270;
	Tue, 24 Sep 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182278; cv=none; b=dAp3UT45yNKZ6KbRcXq7MqQ7BSygVbJbKJ44biWcnh4kL1/G+XQOZjmvzOlCKoRSxDbimpsA9bY+Zaa1OvkfxKqCW4gwfxAcEzkdDUJ4eywWd7rSqqNjmzghqPhhtiqJt5UCnTJ5ag/svI1tSa7MW2QK/DkYmaYkSgu0dgPBp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182278; c=relaxed/simple;
	bh=bCdAJtWcw8XYVzNHD5RzXl25gbQGRkmRSDJDBvQuRpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8zL8Zrv7mCCUm5eQ4tZFFMlUqdNpk8g1xChswFEtpgU7DXQixmWcRy07UkMNoNbACxUkUIsVPQuRyvCpixIVpYs3nq6jwv6xBBAg3JHUcGqtzO+oBv9bAsaUuNVDDT+ef8e4Vqw3L+NMRb2kk71qzKVrZzBwAbO7IJZ04t6VFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAnMo7i/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so34950215e9.1;
        Tue, 24 Sep 2024 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727182275; x=1727787075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHbX6C+iwqwm8Kk4SuwZ7KOdiQYQGIgPlwXmHwqRcEM=;
        b=dAnMo7i/dNC/ulegUiNBk6lz+leMckxXE8ck64bXZEeLV/yDKCJoR+z1Xt9liYXwwD
         UsQJ1VHOCxbeJTWH+5Ttsq4aF7jMNJlDLhDgz7Z77fUiGi9oE4GastUmpDNVhLgU5zAA
         3H2XIx50YvL96WGGgbNIAIaGdASiAheRIQPkhLPYOUPxii9iV9HQtemurUizofyXk30x
         q/ey5NT6dg9Hxvq32bp2FJ/smkiQQ+b5fHgeDtogmzO9fKKCVeehfvl7PyaQQVi3IDJ7
         tibS/AKSA5z2tJ2rfphPnBhtcNYSVZ3Xmp0sLM/1u3KGU4ebLC2SPFLPlfduvl5h1aYx
         j8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182275; x=1727787075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHbX6C+iwqwm8Kk4SuwZ7KOdiQYQGIgPlwXmHwqRcEM=;
        b=awaLW2pDlZRpkdRelKgLeXavsUAjOrUyQHyMVam0p2a7ZHUw30+kLXfndfuRJvco+k
         EWxwgzrRK9fdKnHD92105IswMkoJXa84Fg3QY8gjVY5HTLyXpT2yItF1vrNIBg+XOl0P
         f91Y+JTqMOZTRbwHXAE7xcFV1CUMNXcqFr6HjbIoN2k0s75YQ4LKWQVgLs2oib/zjTL6
         pYTaDcbtyzkmnsC51hjL9jIoqhalRyTN12Uhnspq/7SkcDQZCWh13Rh0X1MA2MGOCyO5
         2Vh0l4K/obH5WKMrT5HLqowBJO1YMIQ+lO9TZaJF3T4GWDPn5hvV9IhP8DIK25ywH3Pf
         LwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXYshLWRFr9icef5NfX1OXgc4sQqtnBipbzJZJG9+svD1dcUcPIDyIwwZqdI90Pi4ReG3ImBHlRwvY0Q==@vger.kernel.org, AJvYcCUzUBiZBc3Ass0tbdJNO/JHHLpycbJ0dL9pFWaVzgQe2FeigyuZ8LybAGR9j2ny3Tz5OQpn0oz9R4mTXeLB@vger.kernel.org, AJvYcCVa9bFThFIG27pYuVKIaJKHy/nqW1BWby7K2arnumv6fRtGWguXX2ZFZEmL+zGzRY+69+rw7KixJd87TLn2@vger.kernel.org, AJvYcCWf9zE79mcyfl04YMBqYpxP4/AL12UDbZHm0EquaBuJg49mf9WdhQ6X6zSXLbVKOV44ayJV0367MaekMg==@vger.kernel.org, AJvYcCXVPnfFloygKUylm0SZAOZTO/6XIH8MyK8TEZTrz+WkdCB+Dpwu7+eO3kf7l4nsGbsIOWOEz/7fsaOV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7p7gcTjt3ST3HJ4PBNx7sqIbkVAhE2pWCqgyVAXNZ4v2mJmnE
	evDBypie9Y7XMKlnzmE8EiKSCaYTnUxVhST59LWVLB7jqXuqwt+t
X-Google-Smtp-Source: AGHT+IG8CJbGSsWrhk0RoDKSkZtOkqkFEZPle1hqFRzEA33L/mzQTzHGgU1UEiSLTnurIlayVBWh1Q==
X-Received: by 2002:a05:600c:4793:b0:42c:b7ae:4c97 with SMTP id 5b1f17b1804b1-42e8f37699fmr17877285e9.11.1727182274747;
        Tue, 24 Sep 2024 05:51:14 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7543b0f9sm156890475e9.14.2024.09.24.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:51:14 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:51:11 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>

On Tue, Sep 24, 2024 at 12:16:27PM GMT, Lorenzo Stoakes wrote:
> process_madvise() was conceived as a useful means for performing a vector
> of madvise() operations on a remote process's address space.
> 
> However it's useful to be able to do so on the current process also. It is
> currently rather clunky to do this (requiring a pidfd to be opened for the
> current process) and introduces unnecessary overhead in incrementing
> reference counts for the task and mm.
> 
> Avoid all of this by providing a PR_MADV_SELF flag, which causes
> process_madvise() to simply ignore the pidfd parameter and instead apply
> the operation to the current process.
> 

How about simply defining a pseudo-fd PIDFD_SELF in the negative int space?
There's precedent for it in the fs space (AT_FDCWD). I think it's more ergonomic
and if you take out the errno space we have around 2^31 - 4096 available sentinel
values.

e.g:

/* AT_FDCWD = -10, -1 is dangerous, pick a different value */
#define PIDFD_SELF   -11

int pidfd = target_pid == getpid() ? PIDFD_SELF : pidfd_open(...);
process_madvise(pidfd, ...);


What do you think?

-- 
Pedro

