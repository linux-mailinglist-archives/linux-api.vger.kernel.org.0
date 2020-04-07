Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D873E1A103A
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 17:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDGPcV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 11:32:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37646 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgDGPcV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 11:32:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id j19so2307830wmi.2;
        Tue, 07 Apr 2020 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9+2iih/O2ZGrwXPlPA6epkbehyL9r0ADOqLYSpcHNE=;
        b=JRf2Qmhm/4s/sucGs/OAtRnuw6ihYoPn8MCfnhdh+5ksBicPo+gOgwG+zluZJCjCsv
         7ZwprP6aYLAX+eKBmDHz07gE/S2zB8UGAnA8Ik1gseeQiViRWSWBp6GNspJnjFqwcu/A
         jeWDBr+EuVORaiX9yQ5salmw+BGq5FWVjoZH7X83lmVWD5T69kLAfovLmT0sPgzNuJRe
         njx8CAOSwapf2OJ3pYWngliZzuRtdDjjQHgg9WVuLX5fesZbnHnrpLO3KFZ3ht0AFm/T
         RKsw91R7MeILo3FMXdZXFhKNUH2MjNAtm4iMboMnIe6CP1clG+NGNXYumaEfiRh7kzEK
         bvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9+2iih/O2ZGrwXPlPA6epkbehyL9r0ADOqLYSpcHNE=;
        b=qCZKXqF5s1zuAsbQTa7n5Xl0D3Aj6rYTB4zmCbNELaxI8PqDPR+0EhAU0o2bK/siv1
         1PxBUR85b/0FYGHmaRU/fPa+nyMYPpoV0v2kVi7jW0QXqlIiC9ZX/dwYzEqXvHZQsNPs
         xISMfEFmtYZGOUuUOSFwbwaktcws8aRp+qI9BHRfGtchzgCTu4opxZLgxLIxNqLTCDOr
         gNV/rRdz7jMl6aN6dlykPTnHN7xbRIJu1Am4+uEjyvorrm6YUcY7Yfu9GdVD2RzGQC+d
         Bx5+2nSN3PjVsT1Ww5H1dp88BioarPYzClmzAPphG2SgJVLlzq01Q9k+9RpszJ7jzdJP
         Mylw==
X-Gm-Message-State: AGi0PuYv7AHhFzhW3U/gmTGgk0P+KfLHDI1d6qx+ypD0paq0EmgKSUlD
        8kXzBrUMlsG5SBZsNjxGHgs=
X-Google-Smtp-Source: APiQypJGHKrnzXy1rIZybzrX5czjSZYOE7qA2lllJAX/JcbuGsJ159zXnLKXq64hN0aKCMDjVZkKSQ==
X-Received: by 2002:a1c:4085:: with SMTP id n127mr3059598wma.163.1586273539400;
        Tue, 07 Apr 2020 08:32:19 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id p5sm6375221wrn.93.2020.04.07.08.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 08:32:18 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        linux-man <linux-man@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Adrian Reber <adrian@lisas.de>
Subject: Re: RFC: time_namespaces(7) manual page
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
 <20200407032318.GA494464@gmail.com> <87r1wzk2p5.fsf@nanos.tec.linutronix.de>
 <fe940759-9159-5d89-1f5b-f92fa247177f@gmail.com>
 <87lfn7js4f.fsf@nanos.tec.linutronix.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <445b53ec-df68-1edf-dfd9-2882b3607e55@gmail.com>
Date:   Tue, 7 Apr 2020 17:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87lfn7js4f.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/7/20 4:19 PM, Thomas Gleixner wrote:
> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
>> I've tried to capture this info, as well some other relevant errors
>> in the following text. Does it look okay?
>>
>>        Writes  to  the  timens_offsets  file  can fail with the following
>>        errors:
>>
>>        EINVAL An offset-nanosecs value is greater than 999,999,999.
>>
>>        EINVAL A clock-id value is not valid.
>>
>>        EPERM  The caller does not have the the CAP_SYS_TIME capability.
>>
>>        ERANGE An offset-secs value is out of range.  In particular;
>>
>>               · offset-secs can't be set to a value which would make  the
>>                 current time on the corresponding clock inside the names‐
>>                 pace a negative value; and
>>
>>               · offset-secs can't be set to a value such that the time on
>>                 the corresponding clock inside the namespace would exceed
>>                 half of the value of the  kernel  constant  KTIME_SEC_MAX
>>                 (this  limits  the  clock  value to a maximum of approxi‐
>>                 mately 146 years).
> 
> Yes.

Thanks!

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
