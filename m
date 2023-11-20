Return-Path: <linux-api+bounces-101-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59527F21CB
	for <lists+linux-api@lfdr.de>; Tue, 21 Nov 2023 00:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0D4282543
	for <lists+linux-api@lfdr.de>; Mon, 20 Nov 2023 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E03B7AA;
	Mon, 20 Nov 2023 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkBhQsQv"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC4BE
	for <linux-api@vger.kernel.org>; Mon, 20 Nov 2023 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700524628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znhhgLdmAWpUPn9GHqUr/8E6KWdCC2feKOkD+ky/o8U=;
	b=VkBhQsQvEOrf4BB15oA3oSwupWqB2Kllp81F/bs8O871BFsDGjcrBbePZN3ZtguUFtPMiu
	SX3e43W95dAp6T+7/X/qSg0fe+ZsWGinjShqNTVhlGyjh2S4bNBOprc8XlIlAhBgHOFw2a
	H5kiYMxhCUY7H3RuZrrhtYMw5s9Zrns=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-xm5zH-F5NDanSqTnyUXtEw-1; Mon, 20 Nov 2023 18:57:06 -0500
X-MC-Unique: xm5zH-F5NDanSqTnyUXtEw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1f5acba887bso5321515fac.3
        for <linux-api@vger.kernel.org>; Mon, 20 Nov 2023 15:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700524625; x=1701129425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znhhgLdmAWpUPn9GHqUr/8E6KWdCC2feKOkD+ky/o8U=;
        b=c6moPwvoUCC1LfieDunjWtUZT9nq4nN2rx2nWgoeBsxloI5+694DTxbubHIae3gSYg
         KcoiYHufr/UaOrZ+Zu3QYjLWwW7xHa8cRPb8HKcrAi85UXPC0Fk6/1uhlZ04W/jg3hGk
         KUPtuVWkLKfRlgitRLJsbwlhfEOF6kqFids//+Bzv1OWtxkyQg0OHeX8zJ85p6aSorMy
         uLTa9xdEMZvD2R5n4GErtzmIMjMvbCTgPPaunh1CML+B21m/iBo7QRrYWLEGwVx1bQ1k
         D7sHUXf8MTgLlLb2G74QpVAhFgl5bM5bPR2AZjpbxz2EAdNDlNc8G+TsgPR/CYuqu8uk
         Wo/w==
X-Gm-Message-State: AOJu0YyPpYRrclpJFAt8yIQi6Mogh2p2d9/73j3686Pq9p5+iJxMk51K
	FTGlKzTe0COaLwKRu0DAB+1hfvYCJdcYngh7i996KAXy3WiLzKG36+/g4/3qCALuuoz2eYjPraU
	pN1pLjFrl5mwUd5XaAiSOQBAwCdKGdLQ=
X-Received: by 2002:a05:6870:b4a6:b0:1d6:b7aa:c6ed with SMTP id y38-20020a056870b4a600b001d6b7aac6edmr10935784oap.56.1700524625743;
        Mon, 20 Nov 2023 15:57:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3kvlgcQckGHpb2R5jSIU328bNbYbFOFTRp64CPF5uDJXJxeJoHQaM1YVmEmBSMMZcmeugfA==
X-Received: by 2002:a05:6870:b4a6:b0:1d6:b7aa:c6ed with SMTP id y38-20020a056870b4a600b001d6b7aac6edmr10935776oap.56.1700524625486;
        Mon, 20 Nov 2023 15:57:05 -0800 (PST)
Received: from ?IPV6:2403:580f:7fe0::101a? (2403-580f-7fe0--101a.ip6.aussiebb.net. [2403:580f:7fe0::101a])
        by smtp.gmail.com with ESMTPSA id x19-20020a62fb13000000b006870ed427b2sm6758263pfm.94.2023.11.20.15.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:57:04 -0800 (PST)
Message-ID: <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
Date: Tue, 21 Nov 2023 07:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: proposed libc interface and man page for statmount(2)
To: Miklos Szeredi <miklos@szeredi.hu>, Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>,
 Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
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
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
In-Reply-To: <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/23 20:34, Miklos Szeredi wrote:
> On Mon, Nov 20, 2023 at 01:16:24PM +0100, Florian Weimer wrote:
>> Is the ID something specific to the VFS layer itself, or does it come
>> from file systems?
> It comes from the VFS.
>
>
>> POSIX has a seekdir/telldir interface like that, I don't think file
>> system authors like it.  Some have added dedicated data structures for
>> it to implement somewhat predictable behavior in the face of concurrent
>> directory modification.  Would this interface suffer from similar
>> issues?
> The same issue was solved for /proc/$$/mountinfo using cursors.

The mounts are now using an rb-tree, I think the the cursor solution can

only work for a linear list, the case is very different.


>
> This patchset removes the need for cursors, since the new unique mount ID can be
> used to locate the current position without having to worry about deleted and
> added mounts.

IIRC the problem with proc mounts traversals was because the lock was taken

and dropped between reads so that mount entries could be deleted (not sure

adding had quite the same problem) from the list in between reads.


Sounds like I'll need to look at the code but first though but an rb-tree

can have mounts removed and new mounts inserted if the locks are dropped

if the retrieval is slit between multiple calls.


So I'm struggling to see why this isn't the same problem and I don't think

introducing cursors in this case would work (thankfully, lets do this again

please).


Ian


