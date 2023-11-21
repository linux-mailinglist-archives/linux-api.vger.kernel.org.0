Return-Path: <linux-api+bounces-114-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F27F3A41
	for <lists+linux-api@lfdr.de>; Wed, 22 Nov 2023 00:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C975B2191E
	for <lists+linux-api@lfdr.de>; Tue, 21 Nov 2023 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A156767;
	Tue, 21 Nov 2023 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpqJaRVg"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAFED47
	for <linux-api@vger.kernel.org>; Tue, 21 Nov 2023 15:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700609300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDZVRxZweSenkNDTSFX30b9waUaWsjQX3051oVBc2uo=;
	b=CpqJaRVgBpiNEbl5JTPbfpPLoyQu83M/BLDWQK+fU6+Redf4bp+WEdaj1lI3YwkZFMp9Wg
	lYd952b1DtUhwG9DOl163UclKcNI+zLW25f01H6Rw48rfQpJca2JEocWEhc5zx89fXGZt5
	Uo5MCkIvhPCRuSj5XWwMyhyKzqqGei0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-zQ3F_nQXMKS86_citEbPAQ-1; Tue, 21 Nov 2023 18:28:19 -0500
X-MC-Unique: zQ3F_nQXMKS86_citEbPAQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c1c48d7226so9165726a12.0
        for <linux-api@vger.kernel.org>; Tue, 21 Nov 2023 15:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700609298; x=1701214098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDZVRxZweSenkNDTSFX30b9waUaWsjQX3051oVBc2uo=;
        b=sN5O4WbAPLxbG6EHvhCf2/JGvYaVqmVv+kQPEs78Hu47apeFSPDEUcoaWY+1LDF02R
         +k0v8VatLcgjvTp0jn+Nax/nDka2QMNeT+U72iir2TWxgACWsAAzGXPMZJcd43RnKttN
         zzTEge+f/aXj8vUQcOBkDQWU4jViIt5TdO3n4uv2pvUpLhukzjHgUZoinbRHNQ6HnZ2A
         58Q3SCTo5E1Kj+X96GjcJhDNdT8lMx5fhJHK8Ojk/l/UF0lItJxjQNp42wK+6j3xjmWe
         3bamvlN4dVKhPddY9s4Fd83QC8+zdGXizHtfE1Okryl2WxOFNcbQ/uBiKo/JIBDwtPwH
         pNKQ==
X-Gm-Message-State: AOJu0YxnbdTVkCxNMqqC8hIaHoE0IT3Eo58vSjpinxCwyG0irV1VOXjC
	xhuLyY6juXBfth3+asxq1fko3NEDJ9dIMewrRUJbhZTU6tXxVVrNBwCKFaUbzpxTfezt9uzTzmA
	OWJsYluy+nwOklSMTBvMc
X-Received: by 2002:a17:902:ed4c:b0:1c7:5f03:8562 with SMTP id y12-20020a170902ed4c00b001c75f038562mr772729plb.30.1700609297973;
        Tue, 21 Nov 2023 15:28:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlcPQdJ0chVTcdGisrcasHHa3D8gXU0roVA5jhM3ymaKkbeuu8fPoC51DguC+Q5hOBu4pCqg==
X-Received: by 2002:a17:902:ed4c:b0:1c7:5f03:8562 with SMTP id y12-20020a170902ed4c00b001c75f038562mr772714plb.30.1700609297670;
        Tue, 21 Nov 2023 15:28:17 -0800 (PST)
Received: from ?IPV6:2403:580f:7fe0::101a? (2403-580f-7fe0--101a.ip6.aussiebb.net. [2403:580f:7fe0::101a])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902a40700b001ca4cc783b6sm8414750plq.36.2023.11.21.15.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 15:28:17 -0800 (PST)
Message-ID: <698dd63e-9cd8-2d22-c4ca-d8138ed97606@redhat.com>
Date: Wed, 22 Nov 2023 07:28:08 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: proposed libc interface and man page for statmount(2)
Content-Language: en-US
To: Zack Weinberg <zack@owlfolio.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Ian Kent <raven@themaw.net>
Cc: Florian Weimer <fweimer@redhat.com>,
 GNU libc development <libc-alpha@sourceware.org>,
 'linux-man' <linux-man@vger.kernel.org>, Alejandro Colomar <alx@kernel.org>,
 Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Amir Goldstein
 <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
 <878r6soc13.fsf@oldenburg.str.redhat.com>
 <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu>
 <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
 <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net>
 <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
 <bcbc0c84-0937-c47a-982c-446ab52160a2@themaw.net>
 <CAJfpegt-rNHdH1OdZHoNu86W6m-OHjWn8yT6LezFzPNxymWLzw@mail.gmail.com>
 <c1a2c685-6985-4010-933e-a633be647b49@app.fastmail.com>
From: Ian Kent <ikent@redhat.com>
In-Reply-To: <c1a2c685-6985-4010-933e-a633be647b49@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/11/23 04:42, Zack Weinberg wrote:
> On Tue, Nov 21, 2023, at 2:42 PM, Miklos Szeredi wrote:
>> handle = listmount_open(mnt_id, flags);
>> for (;;) {
>>      child_id = listmount_next(handle);
>>      if (child_id == 0)
>>          break;
>>      /* do something with child_id */
>> }
>> listmount_close(handle)
> Why can't these be plain old open, read, and close? Starting from a pathname in /proc or /sys. Doesn't allow lseek.

I'm not sure how this would work, there aren't a series of paths in proc

that represent mounts?


There are a couple of reasons for not creating a tree of directories

to represent mounts in the proc file system.


One is that open() is a fairly high overhead system call and it so it

won't cope well with traversing a large volume of mounts. Other times

I have introduced open/process/close for individual actions, rather

than keep the object open until it's no longer used, has proven to

impact performance in an unacceptable way.


Second is that, because the mount table lives in a file (actually more

than one with slightly different formats) it needs to be traversed every

time one is looking for a mount which has been shown to be high overhead,

especially if there are many change notifications from the kernel.


Ian


