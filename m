Return-Path: <linux-api+bounces-1981-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355DB932E39
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 18:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7A0281EB4
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C919DFB9;
	Tue, 16 Jul 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUzQvUzY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4747A5D
	for <linux-api@vger.kernel.org>; Tue, 16 Jul 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146601; cv=none; b=HYsNIJ0JTmlZg+cAkPDpjufThwl5xtsQxyGW4u01BAKI3n33lPY9svqqb7UPRy6QLt272YOM4WHwEJFSqjqfvzajOnsjCLgJA/8v+Y9cshQIX0FVCp9f7x4WpEWNQMeHnbSXgtRF9QQesE0LklnZouBL9xkFB/oB6VmILdPyqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146601; c=relaxed/simple;
	bh=IKFvNphjiHL0yMWAQT/MRFEIyA1tvFQg6tRyXvKnTso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT/Vc6BicCOyOJhOahGv9kIUXh8otiBsrZaWaCo0e+v+2VeD1+x2ccskVvNdT6D4ypU4+x2nQIhlG8suFm5n+e+UDsd9cN3V2Hf8JBjD0mfYvAXGFwL78tITzmyxX3dX0tz3Dv/t48UOe7ohueWEpJKlT+cUi8JUx0MgFrOLnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUzQvUzY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eede876fbfso41891821fa.1
        for <linux-api@vger.kernel.org>; Tue, 16 Jul 2024 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721146596; x=1721751396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=InUxI+Ncke1VOxRVnKASF7URLILINPYQdfLepR2sqPg=;
        b=BUzQvUzYqWn59qv2PQeSq25qPL0AoAFz8KWp0GVNqHv1ttutGUBfx0WHW2QphOXk+w
         NG46NZpt665PDU/QIuh1IQ1WOvpD90PkIF7NVj0bO/QHmUOSP6H3MWM9XZ51LaOt77t9
         rjUORVdY8jezLa1iDN5JlDv2WDNY6uPoBuA/rgTaB3O1tuaRfM8/feCO7Ntr31JbxPed
         oEaCZp6dxkQ5jUJLNcusNlq1TQPb0B9uvEOE3+vtpUkx0C7hk1H2bo+rKmEfwCttN7hD
         1voKuzTg0LotmvfoClT0hCoTU2dfL93vXmaPCcKv8ZNQU8e11uXL7fhQzrenkjVLhEEH
         EPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721146596; x=1721751396;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InUxI+Ncke1VOxRVnKASF7URLILINPYQdfLepR2sqPg=;
        b=A58O0OAzVoOb87leyC6j0PbNywyM0V+vtPLPsfRbn2CKkW9PjwuNHyNjSBGszQtPne
         O1dgJIC+HZ1QDS9iE6mm8oFTcNZIkyjlelQIcnR6sUh5nyxkMusg/tbpu7xObjlpWd0L
         iz9hnAtgp5/H4hp7vkbmGjCbSrCvcgHMRJWsIHMpZkN0MMcmnWi9yWsAIHwbs6eFmRGs
         Aok3idvPjwY3qXsw/sqyrm1sJr3StLVqNXQyNw9JToSFg9ffwYpCdQ9Un6Tip3KMKlZt
         XW3cQpwSVeicOCAJw8lVZNX1Slxs+ZHnNwzbyyF4odI9Kgn124+2XnwCbQZ+BuMfUKzW
         0tVQ==
X-Gm-Message-State: AOJu0YzoKgdFFrthywd9+KeYMwQyxYheaUUdIqw+qeGiNSEae1BCWchD
	LckHceVOZCKk8i14d9iLLOd8tBEZ7I8lVJHWKQuSjx5+Hn4bRpIjTYc+Kw==
X-Google-Smtp-Source: AGHT+IHPHOb4BJdVum2vdCXQlYly9elJ+cf3HWPfwqtfmmpKSUIUUAB0PzUi1eQ65m7/9feUv+hhtg==
X-Received: by 2002:a2e:988c:0:b0:2ec:1042:fb04 with SMTP id 38308e7fff4ca-2eef41d90f6mr18199251fa.35.1721146595864;
        Tue, 16 Jul 2024 09:16:35 -0700 (PDT)
Received: from ?IPV6:2804:431:cfcc:c37a::536f:6e69? ([2804:431:cfcc:c37a::536f:6e69])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2eee17ad529sm12301731fa.38.2024.07.16.09.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 09:16:35 -0700 (PDT)
Message-ID: <67d71aa6-8ad3-414f-a6da-736481758614@gmail.com>
Date: Tue, 16 Jul 2024 13:16:30 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mprotect PROT_SIGNAL
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org
References: <f01d236a-e713-4953-be8b-1484201f8190@gmail.com>
 <87ikx5z7xp.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: "Soni \"They/Them\" L." <fakedme@gmail.com>
Autocrypt: addr=fakedme@gmail.com; keydata=
 xjMEXwNi3hYJKwYBBAHaRw8BAQdA54PbCsby/5RoB/LcXM0ErtTf8Dg9vIlUXrCXz/Au4r3N
 J1NvbmkgIlRoZXkvVGhlbSIgTC4gPGZha2VkbWVAZ21haWwuY29tPsKWBBMWCAA+FiEEsMoE
 IRiJ1JxhKZryJ/4WYf4YmMwFAl8DYt4CGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQJ/4WYf4YmMxGkAD9Ff/RRgDI+jEotQrJP5fgJECAUEeSiwquzAolp2ersZkA/1wr
 FdAe6U4id6efkAEtjfEJJ+GmU2vgSPXzqieza6kEzjgEXwNi3hIKKwYBBAGXVQEFAQEHQKmF
 MuXpl3lzDyXP3c76bJm1midZrosIYpAuoGqD19lYAwEIB8J+BBgWCAAmFiEEsMoEIRiJ1Jxh
 KZryJ/4WYf4YmMwFAl8DYt4CGwwFCQlmAYAACgkQJ/4WYf4YmMxgTQEA+UNWbiMf1MtDpP3Q
 B+HhsKvvRShHeYxkPgSY7lDicboBAOOz5E1jPI62uV0Xe2dM8n7TN+0zLw2fDXJlZFuCoVUD
In-Reply-To: <87ikx5z7xp.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-07-16 12:13, Florian Weimer wrote:
> * Soni L.:
>
> > we'd like an mprotect PROT_SIGNAL flag for a compiler we're making
> >
> > PROT_SIGNAL - marks the pages as unmapped while running signal handlers
> >
> > this would be very useful, do you think you could provide it?
> >
> > (not much more to say about it, it's supposed to do what it says on
> > the tin, we want to unmap pages in signal handlers so as to catch bugs
> > without causing memory corruption.)
>
> The challenge is going to be to detect abnormal exit from the signal
> handler.
>
> You can already get some of this behavior to today with memory
> protection keys, on x86-64 at least.  (I consider this a glitch in the
> implementation, it makes it less useful.)  Access is revoked
> automatically when the hander is invoked.  However, access is not
> restored if you jump out of the handler using longjmp or by throwing an
> exception.

As it should be - POSIX specifies that longjmping out of a handler 
remains in handler context, so you still can't call signal-unsafe functions.

Presumably, an API to manually map them back in would be necessary in 
the case of e.g. the JVM, which uses signal handlers for 
hardware-accelerated null checks.

> Thanks,
> Florian
>


