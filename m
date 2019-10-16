Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2DAD9328
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405641AbfJPN6J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 09:58:09 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41840 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404397AbfJPN6J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Oct 2019 09:58:09 -0400
Received: by mail-wr1-f43.google.com with SMTP id p4so12321111wrm.8;
        Wed, 16 Oct 2019 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=agNGM0+r0bRpxGyTFrM8CjOeywto3DlsON2jMxMZt2M=;
        b=oP1xASFk9dN3PSvh14079JkszzhkjMvZ6q3lgP2Jn8Ww1RnJDvkibuyQfPyENnAi+I
         bf6QTPJVAsMPMInvHnwriUJkzIjzx4NyMPGIkBG0wXBexm5W0p9VpxWAyse77EH7oiBt
         Nq6oL3M4axfYgnl1jB8q6juwDJ8DwZVKpQCC3+axJtxrkc/Kdctt8odRYMP4pb4CwaCq
         nirPHfIVUNmrsnzwC1g8BljSEUpxM/WO+Qqk6eCreIws/gD5lQ2C3Jyr3A0Yj6oWuIRM
         qZ6KGR7saf4DcCdtNunNLdkwFSVj46y4TVeLaaB3X+CcUxkKCXPkZftaQjCABNaE3a0k
         9OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agNGM0+r0bRpxGyTFrM8CjOeywto3DlsON2jMxMZt2M=;
        b=BXWSELem8U+QNKLFcuew6bIA5+Gr0iiyns+cI6MYao3qiivTMNtGJo0GOod55c2QJ1
         XHI/o2HFJOLcxzSAkseSvwnPNOik/7wQeMi0sxD2qJHHJ4UHSfeftOscENu/xwihT/00
         gMgEXjiK7utDKOqyqUQ5VdQ+tgoVpWeWGek2pkxH4/8h5Gus6lWc8iujUDzZiVBsMhwd
         eupMFCLdDx9C84UzsY2gUl6WSSc0IN55i+dVjwayJBjuyk6pK1bazAMMROecVNM5QDrq
         YwJ93GF4yKjLtiije10/UjEkg2c+NTGOhB1X4GUt2Mywhvqxh7eSRFJ6ENaBaJ+GzIsi
         Y/Yg==
X-Gm-Message-State: APjAAAWpzv5sTmYFN5wHCWS2ZwxHMW3c6962ckGQyp4oHShqcc/9bGr1
        FXfrhAnVE+YWZtmAKMUKiYg=
X-Google-Smtp-Source: APXvYqwIUeLdkrCtFN83aAWf5o/i8xnN8NWxaxm7VurNt8Jl1QU49l59jzklvxt1Qe25mD+xUO5j+A==
X-Received: by 2002:a05:6000:11d2:: with SMTP id i18mr2966444wrx.109.1571234286960;
        Wed, 16 Oct 2019 06:58:06 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w125sm4831016wmg.32.2019.10.16.06.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 06:58:06 -0700 (PDT)
Subject: Re: [PATCHv7 01/33] ns: Introduce Time Namespace
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20191011012341.846266-1-dima@arista.com>
 <20191011012341.846266-2-dima@arista.com>
 <80af93da-d497-81de-2a2a-179bb3bc852d@arm.com>
 <alpine.DEB.2.21.1910161230070.2046@nanos.tec.linutronix.de>
 <5f4c2f29-ca68-b19c-017f-d23730f6e871@arm.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <4f60ac96-c684-e4a8-e60d-e90c658db025@gmail.com>
Date:   Wed, 16 Oct 2019 14:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5f4c2f29-ca68-b19c-017f-d23730f6e871@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/16/19 11:44 AM, Vincenzo Frascino wrote:
> On 10/16/19 11:39 AM, Thomas Gleixner wrote:
[..]
>> config TIME_NS
>> 	bool "TIME namespace"
>> 	depends on GENERIC_VDSO_TIME_NS
>> 	default y
>>
>> and in lib/vdso/Kconfig
>>
>> config GENERIC_VDSO_TIME_NS
>> 	bool
>>
>> and let architectures which have support for the VDSO bits select it.
>>
> 
> Agreed, this is even better.

Thanks, will fix in v8,
          Dmitry
