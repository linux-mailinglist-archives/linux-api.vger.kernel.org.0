Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC131222D61
	for <lists+linux-api@lfdr.de>; Thu, 16 Jul 2020 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGPVGW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jul 2020 17:06:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726844AbgGPVGW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jul 2020 17:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594933580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLDq3OcxyKpCr/USzTjJkCi91v74L71ZluKPOuOKGzQ=;
        b=AK09j8hZelGNqpXbktdAAGh7jVch+Jp+Poe1IdweoZXUbyY9qw2nZn2LOUV85iqL4YZKcD
        GVXxIqpeHpv9zfzO2Yn5LqzWT8+t8q66Q2NZnn152BC9LUYiiOM4HfYiWy6UoUk8/zinGe
        GcOjyS2mQpF8uIwtXO5WyQ773WYJ5XI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-gthSMbmtMrOu77D8CLIRLg-1; Thu, 16 Jul 2020 17:06:19 -0400
X-MC-Unique: gthSMbmtMrOu77D8CLIRLg-1
Received: by mail-qt1-f198.google.com with SMTP id t36so4705329qtc.16
        for <linux-api@vger.kernel.org>; Thu, 16 Jul 2020 14:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OLDq3OcxyKpCr/USzTjJkCi91v74L71ZluKPOuOKGzQ=;
        b=b8lbC9Xm4p8jiHbZbRy3yilmTYKp+clcRm2PxXq9BxIEYiKripZ5qp7aPvxepFSD+p
         jSaTa3Wa5WepLp29nq+Iu2PY3mADAywKjso7brJN+Adv+49Zhqn00S1kRiNvBcprs7JD
         WsYfLWMOX3P+jJaXlSzkiHIoz3lDyQ0SiIkbTvBIN2cZzsS8wq1l+ge/TAr+G7Qq7gCz
         2xju+relT0yoxzjO+xKbhLqRnEYEjGZRb8nitMn0Qosl5busSjNKFe1TcF0Zd7w8nWFA
         5MDiNktTolPC7gMnKGbKj3slf4fqoGaNZpcVxmRlnmDPlb+RmL0omrymU2HMtIxEH5Nz
         UWKQ==
X-Gm-Message-State: AOAM530Qfa2lqtcT0uI06pajomZqzQ6epJLzqZCYEXWfI3a4KTLvwCgY
        0LuXZsWUZs92Uc68hNEhtnlCeHI8hJIaMLlJcG0PLtYkw2/H1GJz3gD/e6S1YFxBNTXXvaXI2kf
        C8xZ81/gcBiTHvw1bwfEF
X-Received: by 2002:ac8:1baf:: with SMTP id z44mr7415699qtj.129.1594933577269;
        Thu, 16 Jul 2020 14:06:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzCczOckQlwY1nK69Pc/C/n4qYzceHop/94SGB5gIGW9ftGNiz7RdgGl+LrXtddfGguKBnRg==
X-Received: by 2002:ac8:1baf:: with SMTP id z44mr7415675qtj.129.1594933577017;
        Thu, 16 Jul 2020 14:06:17 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id z60sm8839761qtc.30.2020.07.16.14.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 14:06:16 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        gofmanp@gmail.com, linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, jannh@google.com
References: <20200716193141.4068476-1-krisman@collabora.com>
 <202007161300.7452A2C5@keescook>
 <20200716202234.wryj7pj7zmwcrxxx@wittgenstein>
 <202007161324.E75E01B@keescook>
 <20200716202935.yorxrz2om67r366x@wittgenstein> <871rlbjj7r.fsf@collabora.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <d0d8b5aa-757e-4306-5558-0f448db69445@redhat.com>
Date:   Thu, 16 Jul 2020 17:06:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871rlbjj7r.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/16/20 4:30 PM, Gabriel Krisman Bertazi wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
>> On Thu, Jul 16, 2020 at 01:25:43PM -0700, Kees Cook wrote:
>>> On Thu, Jul 16, 2020 at 10:22:34PM +0200, Christian Brauner wrote:
>>>> On Thu, Jul 16, 2020 at 01:04:38PM -0700, Kees Cook wrote:
>>>>> On Thu, Jul 16, 2020 at 03:31:39PM -0400, Gabriel Krisman Bertazi wrote:
>>>>>> This is v4 of Syscall User Redirection.  The implementation itself is
>>>>>> not modified from v3, it only applies the latest round of reviews to the
>>>>>> selftests.
>>>>>>
>>>>>> __NR_syscalls is not really exported in header files other than
>>>>>> asm-generic for every architecture, so it felt safer to optionally
>>>>>> expose it with a fallback to a high value.
>>>>>>
>>>>>> Also, I didn't expose tests for PR_GET as that is not currently
>>>>>> implemented.  If possible, I'd have it supported by a future patchset,
>>>>>> since it is not immediately necessary to support this feature.
>>>>>
>>>>> Thanks! That all looks good to me.
>>>>
>>>> Don't have any problem with this but did this ever get exposure on
>>>> linux-api? This is the first time I see this pop up.
>>>
>>> I thought I'd added it to CC in the past, but that might have been other
>>> recent unrelated threads. Does this need a full repost there too, you
>>> think?
>>
>> Nah, wasn't my intention to force a repost. Seems that several people
>> have looked this over. :) Just curious why it didn't get to linux-api
>> and we know quite some people who only do look at linux-api (for sanity). :)
> 
> That's my mistake.  I didn't think about it when submitting :(
> 
> If this get re-spinned again I will make sure to CC linux-api.

Thank you! It helps C library implementors stay up to date and comment
on changes that impact userspace ABIs and APIs. This patch set was new
to me. Interesting new feature.

-- 
Cheers,
Carlos.

