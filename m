Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D083EA4DD
	for <lists+linux-api@lfdr.de>; Thu, 12 Aug 2021 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhHLMsS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Aug 2021 08:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233260AbhHLMsR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Aug 2021 08:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628772472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Q2PV7VnI4EE36Yroitk5R4cnOmAOmNpL3oeGGqR8U8=;
        b=LW+ut9O0mSQGb0a8qs7oLY2n18S22PavAwktLoGbdleut2wO8w9rBVp1l3/nzaCk3eXt6W
        OkZ+s+/WxvckBC4QeQINlcPevcuxmHfhYjMsGfbGY/+rwYQ9dNVaasGEdxRlEHJCDQwZqM
        +52ExREyYMgPgT6y3vsuVew1QMf7enU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-Hif2JoCSPBOLrjcnVt0TBQ-1; Thu, 12 Aug 2021 08:47:51 -0400
X-MC-Unique: Hif2JoCSPBOLrjcnVt0TBQ-1
Received: by mail-wm1-f72.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so3318621wml.5
        for <linux-api@vger.kernel.org>; Thu, 12 Aug 2021 05:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Q2PV7VnI4EE36Yroitk5R4cnOmAOmNpL3oeGGqR8U8=;
        b=TBmF5flb/j/hLDZzL8HZpoG77D+ffT5Q5Twz5g4R+h/1IyCiWC5wPY59fpAKDc5klf
         k0jf5D3i4PXyyraDRN033pb4os0rMTsch1voQzUbK13owkESdPGEuMXOzdwbx8oGgDYb
         MJg4Qj49akr5hCyCFrY2GT9SpzTr1fuI396xzG6CK3/fWGp/isTUNRY0D5CfraMNtcl2
         q6RXaoh4kB98oRVGj36+Bh31Fb2PtA0XiuNfcYZ+P8xaINvi/KYwlpk0zn5sjnaNGnWs
         CxgLwjL3qiMER1lCRDQjH7vVWdhWCsmlrt1pRI8AptpMs+d7jfBw21Z9jpx6YKvm8ia9
         cLlw==
X-Gm-Message-State: AOAM5319bguEh7q60PRlEeld0gktqGnI3KLM213eAz+B4RKFSBbEuHaA
        gNKMaxMFw2XhqQZ5yZleL8L5RaZaotdcdmTjSks9M4mNIl1y+FtCoyYP4q00ne+s2783XOWrwZE
        czpLIJMjPFwn/Dlm+eS9q
X-Received: by 2002:a05:600c:3644:: with SMTP id y4mr10313601wmq.156.1628772469965;
        Thu, 12 Aug 2021 05:47:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVQ12ODWZtcTQdX51baaEDiT/qZqZ0A623jE9FyRBicdlISiUu/+dSjRRCSRweYcYjSAvmxQ==
X-Received: by 2002:a05:600c:3644:: with SMTP id y4mr10313541wmq.156.1628772469723;
        Thu, 12 Aug 2021 05:47:49 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
        by smtp.gmail.com with ESMTPSA id f2sm1958077wru.31.2021.08.12.05.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 05:47:48 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210812084348.6521-1-david@redhat.com>
 <87r1eyg8h6.fsf@oldenburg.str.redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a57e5120-866c-0b27-8203-0632edda2717@redhat.com>
Date:   Thu, 12 Aug 2021 14:47:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87r1eyg8h6.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12.08.21 14:20, Florian Weimer wrote:
> * David Hildenbrand:
> 
>> There are some (minor) user-visible changes with this series:
>> 1. We no longer deny write access to shared libaries loaded via legacy
>>     uselib(); this behavior matches modern user space e.g., via dlopen().
>> 2. We no longer deny write access to the elf interpreter after exec
>>     completed, treating it just like shared libraries (which it often is).
> 
> We have a persistent issue with people using cp (or similar tools) to
> replace system libraries.  Since the file is truncated first, all
> relocations and global data are replaced by file contents, result in
> difficult-to-diagnose crashes.  It would be nice if we had a way to
> prevent this mistake.  It doesn't have to be MAP_DENYWRITE or MAP_COPY.
> It could be something completely new, like an option that turns every
> future access beyond the truncation point into a signal (rather than
> getting bad data or bad code and crashing much later).
> 
> I don't know how many invalid copy operations are currently thwarted by
> the current program interpreter restriction.  I doubt that lifting the
> restriction matters.
> 
>> 3. We always deny write access to the file linked via /proc/pid/exe:
>>     sys_prctl(PR_SET_MM_EXE_FILE) will fail if write access to the file
>>     cannot be denied, and write access to the file will remain denied
>>     until the link is effectivel gone (exec, termination,
>>     PR_SET_MM_EXE_FILE) -- just as if exec'ing the file.
>>
>> I was wondering if we really care about permanently disabling write access
>> to the executable, or if it would be good enough to just disable write
>> access while loading the new executable during exec; but I don't know
>> the history of that -- and it somewhat makes sense to deny write access
>> at least to the main executable. With modern user space -- dlopen() -- we
>> can effectively modify the content of shared libraries while being used.
> 
> Is there a difference between ET_DYN and ET_EXEC executables?

No, I don't think so. When exec'ing, the main executable will see a 
deny_write_access(file); AFAIKT, that can either be ET_DYN or ET_EXEC.

-- 
Thanks,

David / dhildenb

