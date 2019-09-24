Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E532BD26C
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438840AbfIXTK7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 15:10:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42092 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437011AbfIXTK7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 15:10:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so3207773wrw.9;
        Tue, 24 Sep 2019 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lWZ9+6E2t/Zd1vfDJA5ykQoAoEiNVoNl8UGWaG+7/DY=;
        b=kKCSYyE4MZc1CkdVEicqexOA8OzslqU3jMsv4Meen9NNe8Ay0KFUd+VlAImX5JMxQS
         nSDRpgqoYfJ0VaN96TX1toPpDG/8YkYVZJINNHAXhYHkOXm1K/mEp2E5kLHVmKNj2Lxk
         LQMrU4yYkaMDf+KBBQkkYsS4kSY6ovZAHYkO+ajr/U2C6SPyrgp4V0Bt+nwSL6MpsGW9
         GU7blrpXuj64+cwgmRVHzfSYRHOr7asqgQ1hLnja9haycKNnOLr2JwiCKE6qFBdOxnnY
         gXkMEIrJc+XF26m86fmTNxw206ELihr95f8gUyEJuaL5H0kDW5Idm2glysUAX9L/Brve
         A1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lWZ9+6E2t/Zd1vfDJA5ykQoAoEiNVoNl8UGWaG+7/DY=;
        b=kDdLFymjCWs0fnXvmsd/t3NIkYBkWrRDFWzlKkhOhk8q/1F1ovr9gRrUGbwkFoWXL8
         6e2Rrl1nZinMNrqYEe21jkospsQjTdzFTAci71m1lzYaQp4K+4Dqv46WH/lu6qr8FVsf
         1J2APtist1jopM7fer4xuggKBCzcFkmqT3s90ZsGsNwHRE+yu/56F96vSRJq2ZySpTkD
         7GAIW1muM/hV2rXxQAKBNfrCtGr9+cFBbobe2WHhd4oeRNmduMXs9AjgDwsfJMV8LUVh
         Y+jFei3WaxgrcaBaf/h1dHXDYuevYc9QOp0kTCwEBLf0dZuIQgQ3yW+m2BI8omf/pDRi
         FbRA==
X-Gm-Message-State: APjAAAWdOpKaelbaS8oG8HcjvRJEbk5u302O9iZp+s1tQ3X+OpLzXUJt
        J9XCBXfzFSXR5Mm4fNjVVWwnmTJP
X-Google-Smtp-Source: APXvYqzSDLM1ZB5GuTpOKhQeRIUvWBrnS/vyWQ2rMDtNU40T9Md44pf+kYybsKXuk1x6A9cgSE7dnw==
X-Received: by 2002:a5d:4646:: with SMTP id j6mr3823993wrs.173.1569352256834;
        Tue, 24 Sep 2019 12:10:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:24d6:4e01:ef75:e978:47cd:1c50? ([2001:a61:24d6:4e01:ef75:e978:47cd:1c50])
        by smtp.gmail.com with ESMTPSA id 132sm1388250wma.7.2019.09.24.12.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:10:56 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87ftkmu2i6.fsf@x220.int.ebiederm.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <d6f72bcc-613b-45c5-98f5-67f904ace644@gmail.com>
Date:   Tue, 24 Sep 2019 21:10:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ftkmu2i6.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/23/19 11:27 PM, Eric W. Biederman wrote:
> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
> 
>> Hello Christian and all,
>>
>> Below, I have the rendered version of the current draft of
>> the pidfd_send_signal(2) manual page that I have written.
>> The page source can be found in a Git branch at:
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd
>>
>> I would be pleased to receive corrections and notes on any
>> details that should be added. (For example, are there error
>> cases that I have missed?)
>>
>> Would you be able to review please?
>>
>> Thanks,
>>
>> Michael
>>
>>
>> NAME
>>        pidfd_send_signal - send a signal to a process specified by a file
>>        descriptor
>>
>> SYNOPSIS
>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,
> 
>  This needs to be "siginfo_t *info," -----------------------^

Thanks, Eric. Fixed.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
