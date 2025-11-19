Return-Path: <linux-api+bounces-5380-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F85DC70A84
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7D80928C10
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9906313284;
	Wed, 19 Nov 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+MKxpAO"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993C314D3C
	for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577300; cv=none; b=novFYed31N1LeRtZ9VC/i+jAc51Dzp7bAlQHXl7hwn7etjbyGODFUpRbTmeCVAZq/jIDVexikz6sTpmn2/uCgqxMV3qisS1Jmfham1ZK4iNSo7F/+ldAHxNswrcDM8N+HylxqMziqDFgomdWTCkDWZHDLLcRZ7aAZsmncHjQ88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577300; c=relaxed/simple;
	bh=iX/ybG6HPqAkpshrGv+ORbH78nPHyHdGlGGvt5nfSZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzfdbAGU9t8ytBmsDzb2Fq0FJWKzF8SbOUnBhUL8gyvl01NXTOplRznvLY0kMbrtAgWrW8ReWbtHA+tfbmOTgwY5rbu1kEbFW6tdwGrTTY6msrBHqmKIfWTNsbHvJzVnYbP4uMsOQqAeXV5TguwmbTb2BpNKZTQpO36cXhN0LkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+MKxpAO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so829603f8f.1
        for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763577290; x=1764182090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+POvJ8Ws+92l8UUWtvuhisP25BWZ9HM6mjmX0/Aerk=;
        b=M+MKxpAOQ2iAgiFIyMffJMePSIJ9l8ZLPS/fIg0ZCVdg0SLKmD66n4MDOIij11O84K
         COyoEWTgPdrXXicK29ffbTYr5g/3R9foCL5h6yBu8V3xpTT9eNPXpwbIqKtv28er0rJM
         l6XtdjGVx7pO0lfxYEcX3+YJ25uOY3xf4GyYZVtTkoPvTM8DUSwTGuevIG0WmAmHfCVS
         KxCI00KMEZYLgoBV15MU08goagRFl+hQH+Qfds+hxGJVpwh98WPcm/XvyGDSICO198YR
         i5L0NtJSvgTuELvTGynEI+bWu2RfrgfmHqdHWHsnIrIY7TlLIpHLOvJYzcU2iInTSltd
         2LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763577290; x=1764182090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+POvJ8Ws+92l8UUWtvuhisP25BWZ9HM6mjmX0/Aerk=;
        b=bqEnb9TpCNq96eNaA5dyClVSU8wz4qkxRVWk5XG4nFRr7dnNpy/Zpbs6eM7MWHqlWm
         QRyZffQetlH7Q+RQcxnwx08FxcTP+/KiT7n3opY8veTYX2Nd45yM7h8SDl9pQxgRlZmz
         q9iuWqhinq9lhnQTz1r8KTWRtezZKpbaPqegC0+C3tWno//9cFD0YPM36vtfKmxbNpW/
         /TEMNK+l4vwW5x1kk2Pk7tnXHSri2HpNoZ9Z396MXjhdxUgacud++AO4l4247uBdyL5S
         Ustqsub5KMxKwll6RNOsBNjnVjFXmZcBWYOwtxXhxQ/3QOhZSM7J472S4Tw/kKcrY85g
         15bA==
X-Forwarded-Encrypted: i=1; AJvYcCXWBO9k5O0EaMVHwo2YaCB3js/ChZXXVHnQJ/2EdCCcoS/4T9PlHBTJ5epR9wMzWOVmFolreVKjVKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxD6y3Oxm/rY5/sWI1ki4T3N7rLjuOza0Gv1ypvJ1prp7DQfam
	1iaOTJz0O+Zh7KQuCCDQjsOZb2/7dLuvErLll5WTVG1rGvUujD19hjyV
X-Gm-Gg: ASbGncs0JqwrHjW8U+JId7GEE5r8e4WK02MGM/0zP18Skv5cB2Jup/vkdqF9I1H3X71
	E/rDaj1L+7L+3rpZlvc50NTbNF+zfPuojeSktfWWoQo/w1fhyRSQ09y/beKjcyqLrw/O/Y9taZI
	0Q8Pl9QJmmLbEky6SJkhohFAxuGxBFF7kHZ61ipp7BY3QSDSA7boPi9tUYeyXlRRfA1MlwjCjbJ
	JJoZqSXYuJ9Zgqw3MD761xLSTZQQeNlVCa8dtGAb4MZrOt7B3qB8PYjpGsFcIoH+etQuov8XN8w
	pxbf4ibSCp1BvJF1yDrMGxdXCP7P2LRrJsFQCYhtdi3QpAmORRI2piXXn7SBzVSPbQ0rqEGhXHy
	OcrmgtxFdxWd7tCoCaiwoHkvnOWIhYCUnuCJhLOJUWWoVHDNRGgTHe/XqfndfutZ1FyJAV8vqcS
	reBUHuZDk3yieBD9FaWl0rJ4bLaK0rD9NR8VyEujrIMnHi6MWBmmBc2SxWLEYUKe0=
X-Google-Smtp-Source: AGHT+IHnNneLZz+FDHY9DEP2k8i38PWhPNJ2zyasJSA57R/KNoqMioNiRl0N0/4PhXsFU4l3jnTlvQ==
X-Received: by 2002:a05:6000:2584:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42cb86c280amr239486f8f.0.1763577289765;
        Wed, 19 Nov 2025 10:34:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363c0sm606097f8f.18.2025.11.19.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:34:49 -0800 (PST)
Date: Wed, 19 Nov 2025 18:34:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: linux-fsdevel@vger.kernel.org, Demi Marie Obenour
 <demiobenour@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Jann Horn
 <jannh@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
 jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
 David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Tycho Andersen <tycho@tycho.pizza>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
Message-ID: <20251119183447.7185b739@pumpkin>
In-Reply-To: <87cy5eqgn8.fsf@alyssa.is>
References: <87cy5eqgn8.fsf@alyssa.is>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 14:46:35 +0100
Alyssa Ross <hi@alyssa.is> wrote:

> Hello,
> 
> As we know, it's not safe to use chroot() for resolving untrusted paths
> within some root, as a subdirectory could be moved outside of the
> process root while walking the path[1].  On the other hand,
> LOOKUP_BENEATH is supposed to be robust against this, and going by [2],
> it sounds like resolving with the mount namespace root as dirfd should
> also be.
> 
> My question is: would resolving an untrusted path against a detached
> mount root dirfd opened with OPEN_TREE_CLONE (not necessarily a
> filesystem root) also be expected to be robust against traversal issues?
> i.e. can I rely on an untrusted path never resolving to a path that
> isn't under the mount root?
> 
> [1]: https://lore.kernel.org/lkml/CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com/
> [2]: https://lore.kernel.org/lkml/C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net/

May not be directly relevant, but I found 'pwd' giving the wrong answer
when done inside a chroot (that isn't a filesytem mount point) after
'faffing' [1] with network namespaces.

The basic problem was that two kernel 'inode' structures end up referencing
the base of the chroot - so the pointer equality test fails.

So you could find the path of the chroot without any help from outside. 

[1] Brain thinks it might have been an 'unshare' to leave a network namespace
that cause the problem.

	David

