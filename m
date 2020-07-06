Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC2D21572B
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 14:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGFM1F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 08:27:05 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:31155 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgGFM1F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 08:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594038425; x=1625574425;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=08px2a189zc2nXN1oq9ShmmahZqanekxRx3N9/XMQds=;
  b=tIvNb9Sam47AOVSOr7Ezm/I6LPv7wMzbYcTUwJJwytpdzCHcAr2uyuMR
   yIgP6ADSqxJyZm6zR1FlWahm0MjO+prOMX+lLdxr1b5kUXJKHLKns5SZu
   SVC5Kp45GJpr3mtnRFfOatPejj8r+HCmfVxB09l1yQQOiSTXELKCmiA5M
   0=;
IronPort-SDR: DEkt349oSIozOOwwVrwUyKH5nOEdnyljv3NPedaBA41POCc7zKEjMQe7JZDMaeZy7pi8t3Sqnw
 7AQh536xQKWQ==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="41666398"
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Jul 2020 12:27:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 16768A247F;
        Mon,  6 Jul 2020 12:26:57 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:26:57 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.161.146) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:26:51 +0000
To:     Pavel Machek <pavel@ucw.cz>, Jann Horn <jannh@google.com>
CC:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd>
 <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
Date:   Mon, 6 Jul 2020 14:26:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200704114820.GA16083@amd>
Content-Language: en-US
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D44UWC001.ant.amazon.com (10.43.162.26) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 04.07.20 13:48, Pavel Machek wrote:
> Hi!
> =

>>>> Cryptographic libraries carry pseudo random number generators to
>>>> quickly provide randomness when needed. If such a random pool gets
>>>> cloned, secrets may get revealed, as the same random number may get
>>>> used multiple times. For fork, this was fixed using the WIPEONFORK
>>>> madvise flag [1].
>>>
>>>> Unfortunately, the same problem surfaces when a virtual machine gets
>>>> cloned. The existing flag does not help there. This patch introduces a
>>>> new flag to automatically clear memory contents on VM suspend/resume,
>>>> which will allow random number generators to reseed when virtual
>>>> machines get cloned.
>>>
>>> Umm. If this is real problem, should kernel provide such rng in the
>>> vsdo page using vsyscalls? Kernel can have special interface to its
>>> vsyscalls, but we may not want to offer this functionality to rest of
>>> userland...
>>
>> And then the kernel would just need to maintain a sequence
>> number in the vDSO data page that gets bumped on suspen
> =

> Yes, something like that would work. Plus, we'd be free to change the
> mechanism in future.

So if we keep treading along that train of thought, a simple vsyscall =

that returns an epoch (incremented by every [VM] resume) would be good =

enough, as user space could in its own logic determine whether it's =

still living inside the same epoch.

The beauty of the clearing is that the checks on it are almost free and =

that we can avoid to store secrets on disk in the first place.

The latter I think is impossible to model with the epoch, but that might =

be ok.

Performance wise, I don't think we can make the vsyscall as cheap as a =

memory compare. Keep in mind that we need to check for the epoch in a =

pretty hot path. How bad would it really be? I'm not sure. It might be =

good enough.

My main concern however is around fragmentation of mechanisms. We =

already have the WIPEONFORK semantic in place in user space =

applications. Do we really want to introduce yet another check for =

what's almost the same semantic? With WIPEONSUSPEND, the hot path check =

between fork and suspend are identical. With an epoch, we have to check =

for zeros and the epoch in addition.

Unless we create a vsyscall that returns both the PID as well as the =

epoch and thus handles fork *and* suspend. I need to think about this a =

bit more :).


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



