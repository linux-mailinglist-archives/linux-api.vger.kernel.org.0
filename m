Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6B193B23
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 09:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgCZIho (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 04:37:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39583 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCZIho (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 04:37:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so6631337wrt.6;
        Thu, 26 Mar 2020 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IfcMceZk050/1RcDKsZyyg6HjjpIwvox4QWBU9Bf50A=;
        b=HuuNUZ0uHnuFZ+sJCdz1wTcLiI48YULsKZTNdpZfOQABRfSATrm6LOHvJJc+Vm4CYb
         5JAsBxAULMYvX1EQa1y17BSdKg+edcBwpyjl1UjglRISD3y6fAnyF2lKy9Y2OATtz5kw
         D6YOVbhSGruLJmfDWNwDO2zWqNNylXEtvmi766F00hEPJavpy0bLo2ufHax1SX/7g7Ik
         q0tTIYZKUiyMshcuej1KOd0fPqzLfWmGGLh2j+vP65OC2cKVR8wcZXG/Ff5AP95sJ4Ab
         /LP0kcNIK8GeWgHcT/NrY/QjKa9e2GR8SWBOizBe4dp6eAIjdqaq7MuRvGA9RH1aw6q6
         DosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IfcMceZk050/1RcDKsZyyg6HjjpIwvox4QWBU9Bf50A=;
        b=Gaz0a2nkpWGpgP0UT1oqD86JEhCyR8quI6pz25/F3KS7nEdRmxBb555z/ulq0SUYlW
         q5g7/XytDqVgZbwFQUEbBK48WKNV6R9262aw/FePNNwwx2yTiAyefNT2EEh4S4COnVse
         NU/WOeC9AIwXMQw5JA9hAiJUg03iwSX3SleWMu0tiGgKnnI6rzjLv1NwAZQswsIUCOeo
         bxZnq+B67Hw0dx7tNb4NWW0LfS8HML6Uy0Nz3uRrEHesxQhqOyzjkUtHJw37pO4TuiZf
         juwTDu/FP/4y4toR+Zs0kEoBKQiW93FzSdQIz5Z5niZ3RQGw1umUL5kKR1tKqvEPopvX
         RMyw==
X-Gm-Message-State: ANhLgQ3dOo8uAPk+S1PfkONxApGl79HIfbOEMJDpGvsT8FRVRfB3W7Y2
        LEee+wn6lOLwX9yFl92M/rs=
X-Google-Smtp-Source: ADFU+vs9PqIpXenpBDNxNQdz/1xQJkxGvt3OwiOF9ohtm52FLJXH2rrnXNxztsVvd43rlQ6E9MVm9g==
X-Received: by 2002:a05:6000:1205:: with SMTP id e5mr8522731wrx.73.1585211861704;
        Thu, 26 Mar 2020 01:37:41 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id f187sm2505518wme.31.2020.03.26.01.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 01:37:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Aleksa Sarai <asarai@suse.de>
Subject: Re: clock_settime(2) error for non-settable clocks
To:     Eric Rannaud <eric.rannaud@gmail.com>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org
References: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <a225bae5-e342-fee4-b7fa-c3093ca52fa0@gmail.com>
Date:   Thu, 26 Mar 2020 09:37:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Eric,

On 3/20/20 7:02 PM, Eric Rannaud wrote:
> If clock_id is a valid clock on the system (i.e. it can be passed to
> clock_gettime(2)), clock_settime(clock_id, &ts) sets errno to, either:
> 
>   - EINVAL if CONFIG_POSIX_TIMERS is not enabled (kernel/posix-stubs.c);
>   - EINVAL if CONFIG_POSIX_TIMERS is enabled (kernel/posix-timers.c)
> and the k_clock has no set function (e.g. CLOCK_BOOTTIME);
>   - EACCES for dynamic posix clock devices that lack F_WRITE
> (kernel/posix-time.c);
>   - EOPNOTSUPP for dynamic posix clock devices that have F_WRITE but
> don't have a clock_settime op.
>   - EOPNOTSUPP for drivers/ptp/ptp_kvm.c (they provide a clock_settime
> op that returns -EOPNOTSUPP directly, rather than opt to leave
> clock_settime NULL which would do the same thing, see previous point).
> 
> The manpage for clock_settime(2) is not very clear:
> 
>        EINVAL The clk_id specified is not supported on this system.
> 
>        EPERM  clock_settime() does not have permission to set the clock  indi‐
>               cated.
> 
> To me, the manpage reads like EPERM should be expected when trying to
> set a clock that is not settable.
> 
> Should we update the manpage to more fully explain the range of
> possible errors or instead try to have more consistent errors? For
> syscalls, what's the backward-compatibility contract for errno values?

A man-pages patch would be most appropriate. Would you be able to put
something together?

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
