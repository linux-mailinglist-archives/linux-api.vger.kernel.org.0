Return-Path: <linux-api+bounces-3404-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410FFA69459
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 17:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D986A46063C
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0781DED5B;
	Wed, 19 Mar 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y+r2+hEf"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553B1DE884
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400452; cv=none; b=OYdF5xhaPU7jdiP6J2MeT2HFxg0NeRIWz91q0SITePniaq+utqpZsXqVSFA1Kzq7kyqvLyVnFf+kArNqrkb0Zs+UfklSHrbMkKiMTTSHp+cVW1aotuFg7aezPXozP1rhw7XCufrHXFHXoiEkmkjKWQ3kNdsLAgIMnHMy4Cm51d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400452; c=relaxed/simple;
	bh=n24KzPzMfIDbuu7S5CaFyw0UePwN7haHff4RjRQuRy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tm9DxORHnGN56Ifr1PwyE6NvdhOlp7lpX+AlwTw+99jl649uZAICSmQU5snjMAPeMKbiIm6iY4hovwpz8cLqmYh3037VGKPzWvC/nkNFTkNnes5acY+603GSh3Qxq4hP2hIIDuNTEekzx5Rdu0fdJQh2WAnpwNeuLxHAaM6U/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y+r2+hEf; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d57143ee39so25484335ab.1
        for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742400450; x=1743005250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=y+r2+hEfjU2Zz7ALNOq5svFqzJiE9cuXQdmJA+P20x3ThNxa4mu8TtLObqNVlmroGR
         OlmZyYGQuf90qEw4W3uFuM+qnOHzzxc8ucTo7UpOKYtNKkyBbOReAsQhAQo3E/IP7leE
         E9wx4qFx45Oa2aV/2THQw+dab2TirOSA0A+EQ6K560wTR4bka8wphawWRyI/d1vJFHr+
         qzQXF+jXmP7T7oWdIYtu4AfbRAkJbRlbzJRgprCtUulnirrdugfhtvRDW6HS5GWmBfRc
         krNJStKgc3sx9SLXZLXnd0wZOcaGEL7gXh4wuw7XqjLN2dft+wd5LxMmSpHgutBnovf3
         PLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400450; x=1743005250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=nnRh1Gf+ZZZ9i3g1HEQi96ilD57p13tHHztplmZdDD9twUeXAd9R68gy10ACcazz64
         gwel7d1KaqqxtBQs8dR2oH1pMa7PBjrNKQcAANvQuGweu8PUMGBQVL/cyNjar5Q7FKQl
         daK0WikGraoeajv17UXNupszOFNifrTXGJX8OCuSVm5kr7i3eO8BhAdH0AfD6Y99zqlY
         BH5y+d3fV94qLiABhaEDCkrctO17eZzFUSLtXI+5bl2BVEtwxnuImJ4vFdmKT8nd2Iye
         Wz4yJQtKsG6OF5U1bA6nPTi0Zz2YYKzMfcXP1swojf5HkXIp/XGD93RyXrG2n00WS+dx
         r15w==
X-Forwarded-Encrypted: i=1; AJvYcCUIaZHgL42QmJWG4fOQ7tC/Qsn6fJ8HevbWpTZFjpsvbJ2vPzfLrwwIc8C9CKga80Q5D3xfEYhFEi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQ8yzaFiPOvm2+JT66l03rlW74rNvUZsKrCdKAo4y9+UpP+l5
	ChwWt4f3NxTZP9DX8T9t7ZEHP3T3aiFK0wdnI3HHodiYsg9avIABrlWioYyBggw3I0Hd8iUfcMF
	C
X-Gm-Gg: ASbGncttVrHCG/dTM+mjr4ll/d4mJKXWuVqHml9+U9HLveDetcBXoiN8oih+tG6IoM2
	6jJqRuis9w6Y4dR/jN9TjBpiBM0PDQ0vECnnaYf7VQ5gAcX8QRuD5NXnSI/qR7KS/Rvcb6c52JN
	hkRSPn/fg8e/HUlyktb7Mhe5zGHbX/Oy0ryjjNVubvRBIlknBZpTgc7+BreDDGEqz9PithSF4s+
	dv6Ue5HVRVi1IOUjDeoBaUZCXd/M7Om5j1zZ2kCLHhW0+SaPrZgjofShzruEjVV2fsXYKL76WYo
	Lzc+fMp+APOLg1xBRpbNj68WhqMmDdx4AtopwA7CFkljOX60qaY=
X-Google-Smtp-Source: AGHT+IFDBCFWtf4DEWZHOAZhQMfKg6BVxtB70LM/11gT5po4hUy91hL9GfbCfrY2dAmweb9btJ2fRg==
X-Received: by 2002:a05:6e02:1d1d:b0:3d4:3aba:e5ce with SMTP id e9e14a558f8ab-3d586bb9f32mr38295495ab.20.1742400449657;
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263719730sm3269768173.36.2025.03.19.09.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Message-ID: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
Date: Wed, 19 Mar 2025 10:07:27 -0600
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:32 AM, Joe Damato wrote:
> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
>>> One way to fix this is to add zerocopy notifications to sendfile similar
>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
>>> extensive work done by Pavel [1].
>>
>> What is a "zerocopy notification" 
> 
> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> sendmsg and passes MSG_ZEROCOPY a completion notification is added
> to the error queue. The user app can poll for these to find out when
> the TX has completed and the buffer it passed to the kernel can be
> overwritten.
> 
> My series provides the same functionality via splice and sendfile2.
> 
> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> 
>> and why aren't you simply plugging this into io_uring and generate
>> a CQE so that it works like all other asynchronous operations?
> 
> I linked to the iouring work that Pavel did in the cover letter.
> Please take a look.
> 
> That work refactored the internals of how zerocopy completion
> notifications are wired up, allowing other pieces of code to use the
> same infrastructure and extend it, if needed.
> 
> My series is using the same internals that iouring (and others) use
> to generate zerocopy completion notifications. Unlike iouring,
> though, I don't need a fully customized implementation with a new
> user API for harvesting completion events; I can use the existing
> mechanism already in the kernel that user apps already use for
> sendmsg (the error queue, as explained above and in the
> MSG_ZEROCOPY documentation).

The error queue is arguably a work-around for _not_ having a delivery
mechanism that works with a sync syscall in the first place. The main
question here imho would be "why add a whole new syscall etc when
there's already an existing way to do accomplish this, with
free-to-reuse notifications". If the answer is "because splice", then it
would seem saner to plumb up those bits only. Would be much simpler
too...

-- 
Jens Axboe

