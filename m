Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B33B7A9
	for <lists+linux-api@lfdr.de>; Mon, 10 Jun 2019 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbfFJOn5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Jun 2019 10:43:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37091 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390093AbfFJOn5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Jun 2019 10:43:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so5471429vsq.4
        for <linux-api@vger.kernel.org>; Mon, 10 Jun 2019 07:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rzTYIiPqSMbaB247OwcvP22Dn5ctSBRMkQLSP6g63TE=;
        b=KweaSxXevMUgOSfq/Ft/nC+YXwGjW0JHRp+hLny62Dyukq8XTVoLo7zG+NdkcAJwHO
         NHfBAEifKc/7fchXosdphO9J6X/yr5eK0KNfd45HMitBYr8OhO6x0I/eiT/cWZcjDGfw
         irddSXsWm05GuWgl6WRIGxQYRMuW2W0upMCJz4Z5G4gJPznyHM6zgpf/gZQCBsYygZ9p
         n6ip7MkjCsz1EQ0nprI9I5845sFFs2YJOY+td1DqZWdLkH4pVDIMiObIhfZmfaquHf3u
         op06ccP8piumI+8VJIYJPmJuMIPwFbXhXEQC6RuoG+UgmbNssr1pJWvClGasuiKKwF4l
         CsiA==
X-Gm-Message-State: APjAAAWfVr3sqDsZeXpfETlfk4vHW7I7C5HCJ9DUxLPKoHy4RBSht2JV
        9AK/xjGCEddu4z3RdkTAlDSFxFxIUhY=
X-Google-Smtp-Source: APXvYqzj3JGOnWo66BHBaY1lDSf86H5ulmKxbipFqXHDa+gBq4fz7JnKtO1dzGP3noNi8L0rfXRlQw==
X-Received: by 2002:a67:ed04:: with SMTP id l4mr17840852vsp.179.1560177835906;
        Mon, 10 Jun 2019 07:43:55 -0700 (PDT)
Received: from [192.168.8.101] ([67.69.69.230])
        by smtp.gmail.com with ESMTPSA id a123sm3187094vka.22.2019.06.10.07.43.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 07:43:54 -0700 (PDT)
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v10)
To:     Florian Weimer <fweimer@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
 <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
 <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
 <875zprm4jo.fsf@oldenburg2.str.redhat.com>
 <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com>
 <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
 <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com>
 <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
 <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com>
 <87wohzorj0.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
Date:   Mon, 10 Jun 2019 10:43:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87wohzorj0.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/6/19 7:57 AM, Florian Weimer wrote:
> Let me ask the key question again: Does it matter if code observes the
> rseq area first without kernel support, and then with kernel support?
> If we don't expect any problems immediately, we do not need to worry
> much about the constructor ordering right now.  I expect that over time,
> fixing this properly will become easier.

I just wanted to chime in and say that splitting this into:

* Ownership (__rseq_handled)

* Initialization (__rseq_abi)

Makes sense to me.

I agree we need an answer to this question of ownership but not yet
initialized, to owned and initialized.

I like the idea of having __rseq_handled in ld.so.

-- 
Cheers,
Carlos.
