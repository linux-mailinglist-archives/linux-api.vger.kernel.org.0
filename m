Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00692167EB
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 10:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgGGIBn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 04:01:43 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56680 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGIBn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 04:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594108903; x=1625644903;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=rPP1ZORlP0t65HOCjuJb42HRvL4bq+KnqJKPxZXRfXU=;
  b=fDih2zw/X61TaPve1XLIUg2suL2ZUM6xdy9vImFOa+3PSlR0d1Ut2yC1
   dC/aAvgSZU/NiDkIPCtQrHYyQ5XwnIInYFfdyOPNowJyq/na8Qrf+kX0m
   xcy3IPFyeqNhHK+auJl6uscET6cFXavuXXZaK41JkZUmXSddT4Ngj1e4q
   c=;
IronPort-SDR: eKk0O0VzMcviyHGB2FXnmFwpjxrpl9KvWgplpWDorbhdPNQnXPOM1XKwNvc/DG1OAsB8wbmNRZ
 ZffKSourmB2Q==
X-IronPort-AV: E=Sophos;i="5.75,323,1589241600"; 
   d="scan'208";a="49656887"
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jul 2020 08:01:40 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 1D370A245B;
        Tue,  7 Jul 2020 08:01:32 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 08:01:32 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.248) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 08:01:25 +0000
To:     Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
CC:     Pavel Machek <pavel@ucw.cz>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
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
 <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
 <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
 <20200707074425.GC3820@dhcp22.suse.cz>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <efa55313-ce8a-bac9-15df-167f93c672b3@amazon.com>
Date:   Tue, 7 Jul 2020 10:01:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707074425.GC3820@dhcp22.suse.cz>
Content-Language: en-US
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D20UWC004.ant.amazon.com (10.43.162.41) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 07.07.20 09:44, Michal Hocko wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
> =

> =

> =

> On Mon 06-07-20 14:52:07, Jann Horn wrote:
>> On Mon, Jul 6, 2020 at 2:27 PM Alexander Graf <graf@amazon.com> wrote:
>>> Unless we create a vsyscall that returns both the PID as well as the
>>> epoch and thus handles fork *and* suspend. I need to think about this a
>>> bit more :).
>>
>> You can't reliably detect forking by checking the PID if it is
>> possible for multiple forks to be chained before the reuse check runs:
>>
>>   - pid 1000 remembers its PID
>>   - pid 1000 forks, creating child pid 1001
>>   - pid 1000 exits and is waited on by init
>>   - the pid allocator wraps around
>>   - pid 1001 forks, creating child pid 1000
>>   - child with pid 1000 tries to check for forking, determines that its
>> PID is 1000, and concludes that it is still the original process
> =

> I must be really missing something here because I really fail to see why
> there has to be something new even invented. Sure, checking for pid is
> certainly a suboptimal solution because pids are terrible tokens to work
> with. We do have a concept of file descriptors which a much better and
> supports signaling. There is a clear source of the signal IIUC
> (migration) and there are consumers to act upon that (e.g. crypto
> backends). So what does really prevent to use a standard signal delivery
> over fd for this usecase?

I wasn't part of the discussions on why things like WIPEONFORK were =

invented instead of just using signalling mechanisms, but the main =

reason I can think of are libraries.

As a library, you are under no control of the main loop usually, which =

means you just don't have a way to poll for an fd. As a library author, =

I would usually try to avoid very hard to create such a dependency, =

because it makes it really hard to glue pieces together.

The same applies to signals btw, which would also be a possible way to =

propagate such events.


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



