Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A364F80B3
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 20:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKKT4m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 14:56:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43059 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfKKT4l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 14:56:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so15967948wra.10;
        Mon, 11 Nov 2019 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=afNyM1rFuz9mbiFKTzIX+HVpGlCP6+CF1akcTnJ8j2E=;
        b=eftgotV+Z0l9DZ2VVawY89lmqVQqvxShFGMDU9QKpDfn9URjRDgvm8hNexm11VCJYJ
         OyRnulfVIumVQ3rZRkvBoA8LOWDhUShSMktGgzI1XoqHHrwvgirao986TRc0m/hz22lN
         BbwoNo+lOYGtNKz7QPip77pL/dGQd53Giz1cOxKDDLrpWxVEGrMa1MSyLvQys710oFM/
         XHycUJgxIygXj9mxYOdm8SH4lUf3iBKqr5h7pmTGQPphinGLd/ihTON5LGo2lpvrycKr
         WWAidmLEljbUjD3/Eo+iZYtbjZmkExIN0zb2tbfkxcb/3OlUS9Gf6RnxnfVND1d7QSL2
         VAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afNyM1rFuz9mbiFKTzIX+HVpGlCP6+CF1akcTnJ8j2E=;
        b=b4sKmTs06XhzyWWBMg6dKnOBpiKQRemle6UYXZctCrMVxZjaW22xBu2Z7sauIGm5pN
         8A26blWeVwQKZBg/PaaoVdA6AEoOOuWgNQcaunx0Bo9hAifsZajih8XYucwUVVJ9Ecwt
         pcmkqd3/aSerJtLJaFMm9948+cUQGA6UomHoTBTWLHXS/CN/WuXobCuamMJbMaIOZt9V
         2aaLadt/GaKSPQ8LKJ1PHRj8tuNP6Pj6M+aUmL6bob8uIfJuk6emM+B1c+Ll0bajprV7
         Ejx8Vnje7VAVFUL6nokPsAZYNj8COmnq+ASP/JlIlV9CDr9CmiNBxUJPVPzMOZAxS4HQ
         Rs9g==
X-Gm-Message-State: APjAAAWh+MMUG1hNA7JACca66R1dOkoXZGzLDHdVAJxGeevP3x8dW8dT
        GqM/WgvX05/lzfcAVpHExGT+sm5W
X-Google-Smtp-Source: APXvYqyNHDGK9/q8clX1jNfmOE9Bjl1N8B/qrvJTCIpb8hR69G8SJLJ2ZIiNeZLoB+AtgROLEBeg8A==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr21701092wrf.34.1573502199214;
        Mon, 11 Nov 2019 11:56:39 -0800 (PST)
Received: from [192.168.1.119] (pD9F4D38E.dip0.t-ipconnect.de. [217.244.211.142])
        by smtp.gmail.com with ESMTPSA id u203sm654177wme.34.2019.11.11.11.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:56:37 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: For review: documentation of clone3() system call
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <20191109165349.ec5jkuqt7gtm2iy2@wittgenstein>
 <52e0103b-2bc4-b0c6-274f-ce7effb1799f@gmail.com>
 <20191111113652.m3jmuhoh7whzxypd@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cb1347a3-f6be-1b9e-33fe-8b9ce6b63798@gmail.com>
Date:   Mon, 11 Nov 2019 20:56:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191111113652.m3jmuhoh7whzxypd@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/11/19 12:36 PM, Christian Brauner wrote:
> On Mon, Nov 11, 2019 at 10:02:30AM +0100, Michael Kerrisk (man-pages) wrote:
>>> Yip, sounds good.
>>
>> Are you making fun of my accent? ;-)
> 
> I hope that's no a serious question. Of course not. :)

I know. I'm just playing about with with a common joke
about what Kiwis do with their vowels ;-).


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
