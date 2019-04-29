Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0930E920
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfD2Rcq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 13:32:46 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfD2Rcp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 13:32:45 -0400
Received: from [192.168.1.110] ([77.9.18.117]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8QNy-1hPXqm04bA-004P7i; Mon, 29 Apr 2019 19:31:48 +0200
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415155034.GA25351@mail.hallyn.com>
 <000a64d6-1e22-21bf-f232-15f141092e44@metux.net>
 <20190429154949.GA23456@mail.hallyn.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c95fbdbb-a62b-4ad1-f4be-7d1a8f96f508@metux.net>
Date:   Mon, 29 Apr 2019 19:31:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190429154949.GA23456@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cOoGF4O0ntI/WPSdDzGnTzK38X8AqqrXHbTZWivbx0UCfrWZL/G
 Jj+ShRCDmnv/XYUPHuT5DwIVW48/XSFn11Zxwptd18b7ASF/5PLdTJaONOmRjshmKTB2+85
 WLqEsMstYdqJsobTMcsOCWj2Js1eO7hpRFG5JxtvafQ/pYdVtQuHE/yRL0ahDrbf7hP/5xn
 T7P3oXfD0An2k4SRFg5DA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DHNVwzPmvdQ=:otp/O9JL7oHEqhoLMW3eMN
 1plzeYIy2FDwKunOBfzgAlmFXVKNAiLC5PQpDhJteyCxARePZzZufNp+NVY44WoVNG/hTKUAU
 ivxfi0ooWhuSXGgKQQZOIZjPKR7u1hPENDQm5Lxvn8NI2Ztf6ybJowZGXUhlYKDs37HW/CGs6
 tFvXtF/eEvSnotj2o3BCRol183ro5yrGOt2VDzjoD58BFfOVVfUp7uXupHalSoc2PWPHtkXjW
 UgCiUXv9J1B6UW9110waqz9LXa3VTFtFDpWCoO8pkCacBhwSj3Zqk2UdcnNZiOEh3H8b4Uydq
 M4h7v7gnAfBHbRO+Lns5U7Y70r+6WUWpr2XpMIFrie7isvePp3WYP5SHDy7osBpr16065z5Km
 M2a8DmBg309bysQcZ3WMsSPqnrXXXARypGf/mov0kYs49zmrvewMZnBRUAswjWj1h9k9igWfd
 rDMRfZSqTkSJQnuY74LUCcZyni/1xHce7EUGJFwLf7INrFb80haqLY1BsP5fbO2+RBLdL4DkV
 +jf1ObkV4rKApu8i2fK+tweHlDMbk1tKjfWCfdALOXebi+jiSBU24v/lSdNFhv8IpzaNce0H/
 AKZUO2Gu10qt/BxijhK5mOTCt3nxKG/T0zJvAZEJHwmfZqB/weEOyyKUFddMjNd78nndCqMR4
 FkKkjaBD/uYIR5n69poDbREqg7lwCTYCmotISrI0V0X5VrYv2J+hwLrClGqf61Lb1KYUgT0nN
 S1z37sR5jFBKwpj/M2MAIgNEpmNBmFbXdPqky8VvM+LoaX79Dzjk3Y7+BoA=
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29.04.19 17:49, Serge E. Hallyn wrote:

>> * all users are equal - no root at all. the only exception is the>>   initial process, which gets the kernel devices mounted into his>>
 namespace.> > This does not match my understanding, but I'm most likely
wrong.  (I thought> there was an actual 'host owner' uid, which mostly
is only used for initial> process, but is basically root with a
different name, and used far less.  No> uid transitions without factotem
so that it *looked* like no root user).
Not quite (IIRC). The hostowner is just the user who booted the machine,
the initial process runs under this uname and gets the kernel devices
bound into his namespace, so he can start fileservers on them.

Also the caphash device (the one you can create capabilities, eg. for
user change, which then can be used via capuse device) can only be
opened once - usually by the host factotum.

There really is no such thing like root user.

>> What I'd like to achieve on Linux:>>>> * unprivileged users can have their own mount namespace, where
they>>   can mount at will (maybe just 9P).> > No problem, you can do
that now.
But only within separate userns, IMHO. (and, when I last tried, plain
users couldn't directly create their userns).

>> * but they still appear as the same normal users to the rest of the
>>   system
> 
> No problem, you can do that now.

How exactly ? Did I miss something vital ?

>> * 9p programs (compiled for Linux ABI) can run parallel to traditional
>>   linux programs within the same user and sessions (eg. from a terminal,
>>   i can call both the same way)
>> * namespace modifications affect both equally (eg. I could run ff in
>>   an own ns)
> 
> affect both of what equally?

mount / bind.

> That's exactly what user namespaces are for.  You can create a new
> user namespace, using no privilege at all, with your current uid (i.e.
> 1000) mapped to whatever uid you like; if you pick 0, then you can unshare all
> the namespaces you like.  

But I don't like to appear as 'root' in here. I just wanna have my own
filesystem namespace, nothing more.

> Once you unshare mnt_ns, you can mount to your
> heart's content.  To other processes on the host, your process is
> uid 1000.

Is that the uid, I'm appearing to filesystems ?

> Regarding factotem, I agree that with the pidfd work going on etc, it's getting
> more and more tempting to attempt a switch to that.  Looking back at my folder,
> I see you posted a kernel patch for it.  I had done the same long ago.  Happy to
> work with you again on that, and put a simple daemon into shadow package, if
> util-linux isn't deemed the far better place.

Yeah :)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
