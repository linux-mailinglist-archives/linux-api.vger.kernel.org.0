Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207EE7E6C2
	for <lists+linux-api@lfdr.de>; Fri,  2 Aug 2019 01:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfHAXqo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 19:46:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbfHAXqn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Aug 2019 19:46:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so22145690wrt.6;
        Thu, 01 Aug 2019 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QeFuBP9JKrZCeHFf1rpKgsYUuBTv3R+2TjgNB/pftBU=;
        b=BsQiRLSFEzFxFkoLp6ctIPQIKe1NJLA6ZKb8oqi3jFnLK8ustlV+YGmw4+9Q2iibOG
         6XZmONx2pX/bs7wwnxinAObrKqMQ4jtTERHbGL4bDjkvpM+gDc+Jp5j8hQtxh+GTf7yT
         dDFDfpWlaIF095ENGwNtT7Pfzpy/278F/X63j0ylPyerHXxsTOJ97h+GavPDtAdIGNa7
         Hsz/l4M4z/737Fnw4SecAXf5Ost/qc2wNNbcRxwYHa1MsQ0dc7XrXVXd8oMS1lLYLSIJ
         BG0cPWp+sMGjnRVmlzSSbvBwb8oyCPFzCdTgYDFP4n/upnZH04IyjdIWtEB9o/fsWohl
         zL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QeFuBP9JKrZCeHFf1rpKgsYUuBTv3R+2TjgNB/pftBU=;
        b=T4OZ/RXzvN133OPCZLu+hlOCjrlJFZK6MZdSBE7L7IHaajGDE5SPPTDQvTsuOBsYvy
         c7rqCnIPRbV5zgeg7lDuBvPi7KKosLPPx6kuzE82uThYjEpAjqw+vEzkXXveO4d9SuQu
         07VTtP76+3Bv1VnI5UUQx0yeAn+4KM8tdpH8sqnqA4vpWEcm0FQuah5Q7C9iaV0ICeYe
         SNnxpL6cvipqkr5yk8UAW8ER6PC7ZWLg0KrEUrEGRqSl7hr0Fsp3zxMbZBY7V7U6u/ud
         nuDGuRfTtBTYGJo7V1Ww0q+B7EBYqitWFYbHV8/F0A0BC89AE/P+oLX+Dw67ABrmqLM5
         4rGg==
X-Gm-Message-State: APjAAAWXvXh+qaHOn7sEEzhkKveefdaMMAvt8EfUORE77SyqiFnihUNI
        yznaJpzc1R6B6qLtdzC+708=
X-Google-Smtp-Source: APXvYqzJCtFYQPVbIz7G6pETEDSPiYeHoAs11jF1K3cM6cXdE9D49HduHslWE4zb3ftxaZI90sRQWQ==
X-Received: by 2002:adf:e483:: with SMTP id i3mr13171471wrm.210.1564703201468;
        Thu, 01 Aug 2019 16:46:41 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o3sm60526711wrs.59.2019.08.01.16.46.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 16:46:40 -0700 (PDT)
Subject: Re: [PATCHv5 01/37] ns: Introduce Time Namespace
To:     Andy Lutomirski <luto@kernel.org>, Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
References: <20190729215758.28405-1-dima@arista.com>
 <20190729215758.28405-2-dima@arista.com>
 <CALCETrWHEcaG9gZe6ACt5H1H+P8D0RobrJ_bf4Wf9ts40NMM9w@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <4d8d8489-28c8-259f-23a9-ed2b89699b73@gmail.com>
Date:   Fri, 2 Aug 2019 00:46:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CALCETrWHEcaG9gZe6ACt5H1H+P8D0RobrJ_bf4Wf9ts40NMM9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andy,

Thank you for the review,

On 8/1/19 6:29 AM, Andy Lutomirski wrote:
> On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> From: Andrei Vagin <avagin@openvz.org>
>>
>> Time Namespace isolates clock values.
> 
>> +static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
>> +{
>> +       struct time_namespace *ns = to_time_ns(new);
>> +
>> +       if (!thread_group_empty(current))
>> +               return -EINVAL;
> 
> You also need to check for other users of the mm.

Oops. It seems like, if the check was

if (!current_is_single_threaded())
    return -EUSERS;

instead of thread_group_empty(current), it would address the concerns
from 23/37 and 25/37 patches, too?

> 
>> +
>> +       if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
>> +           !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
>> +               return -EPERM;
>> +
>> +       get_time_ns(ns);
>> +       get_time_ns(ns);
>> +       put_time_ns(nsproxy->time_ns);
>> +       put_time_ns(nsproxy->time_ns_for_children);
>> +       nsproxy->time_ns = ns;
>> +       nsproxy->time_ns_for_children = ns;
>> +       ns->initialized = true;
> 
> I really really wish that setns() took an explicit flag for "change
> now" or "change for children", since the semantics are different.  Oh
> well.
> 

Thanks,
          Dmitry
