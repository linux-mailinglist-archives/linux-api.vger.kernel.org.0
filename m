Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51A6156413
	for <lists+linux-api@lfdr.de>; Sat,  8 Feb 2020 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBHL6N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 8 Feb 2020 06:58:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40100 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHL6N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 8 Feb 2020 06:58:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so5500351wmi.5;
        Sat, 08 Feb 2020 03:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vBE5AVqXC0jJd2IELgOKKd2Jzb73ungCmQ/Jq8SLGcI=;
        b=peE/kTj5TpVgBJdlfxiUZ7HXDSWPeUe9DfOIg62trcM3APZC98dqNWTA6fXFuyjtkQ
         jsDrYKyYH3TEP1ybToSY4wHygUmePyYK0KI/n+iBY01ZXUxJUwVejt9kFL94PZAo95Sf
         DTlzq+SDWnDi8022/pHuDQ+lClked+nu+0gmbPZ3o2Lh0unwFfDTrs1G36mBkVIOThmU
         zL/ulG9pkHNfGtZh9WLbZNTTwEzEFLFMc/nsC7KYSEwm+7RKrCO9c4BMv2zy3rnlXAXH
         HE1vPKsBrKlyTLjP+Ili4ZWrrbaB6k0E3e1UbxI+JePpj0Op1NvQt8/i2Tqe4QoHPvBA
         v9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vBE5AVqXC0jJd2IELgOKKd2Jzb73ungCmQ/Jq8SLGcI=;
        b=hmOtQ4axgaV6IB5Q4Ey1IvD+367FWyoYyGwqVsVaWp9PHPaK9eWOTp4UZ/Zkz8Kugv
         9FknO9NewLkzJ7K8/u2SjebdD4/q8NyUxyp0aIxpzkknpNjYWNn8IlZNuc8g9rEY1MtE
         JboVszkmts3udFuadXWZLVwWHbMIAWy95eCIYiXU4o+9pfWsjYNZ67kX3CK6xRpk7jOj
         fMfOpOubrvzOSFuWX8AbhWI8NLp1k4ds1CNNkicsTeKXS7tPGoCJzbPGnkYyXq7g6f1s
         5KiLkMeg68USwjdU5RUnUv7ABwas8EH11z3Gg4FPToyojPHoIjCWu72BNWmWe+V7zUXq
         /9wQ==
X-Gm-Message-State: APjAAAUGaHfXUAu4iUJNZinu9N6srYb+cbTRra7Dv8+dJ/JDnU/M9sCp
        xDpmfWsRs2vqYZNvOPPyP4g=
X-Google-Smtp-Source: APXvYqxnlY92D1d84fYMChfOF8tvWl+OlsJkPK6jre4MkBM320LFYTLEMMQibJKx9zuinresGyXi8g==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr4078411wmj.19.1581163089060;
        Sat, 08 Feb 2020 03:58:09 -0800 (PST)
Received: from ?IPv6:2001:a61:251f:d701:c8c9:6ecf:205c:abb7? ([2001:a61:251f:d701:c8c9:6ecf:205c:abb7])
        by smtp.gmail.com with ESMTPSA id g7sm7365690wrq.21.2020.02.08.03.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 03:58:08 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -manpage 1/2] fcntl.2: Update manpage with new memfd
 F_SEAL_FUTURE_WRITE seal
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
References: <20190314214844.207430-1-joel@joelfernandes.org>
 <20190314214844.207430-2-joel@joelfernandes.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <11efee1c-0b65-2e51-0aa6-7f61fd2958c5@gmail.com>
Date:   Sat, 8 Feb 2020 12:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20190314214844.207430-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Joel,

On 3/14/19 10:48 PM, Joel Fernandes (Google) wrote:
> More details of the seal can be found in the LKML patch:
> https://lore.kernel.org/lkml/20181120052137.74317-1-joel@joelfernandes.org/T/#t
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks. Patch (finally) applied!

Cheers,

Michael


> ---
>  man2/fcntl.2 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/man2/fcntl.2 b/man2/fcntl.2
> index fce4f4c2b3bd..e01e2c075b5b 100644
> --- a/man2/fcntl.2
> +++ b/man2/fcntl.2
> @@ -1525,6 +1525,21 @@ Furthermore, if there are any asynchronous I/O operations
>  .RB ( io_submit (2))
>  pending on the file,
>  all outstanding writes will be discarded.
> +.TP
> +.BR F_SEAL_FUTURE_WRITE
> +If this seal is set, the contents of the file can be modified only from
> +existing writeable mappings that were created prior to the seal being set.
> +Any attempt to create a new writeable mapping on the memfd via
> +.BR mmap (2)
> +will fail with
> +.BR EPERM.
> +Also any attempts to write to the memfd via
> +.BR write (2)
> +will fail with
> +.BR EPERM.
> +This is useful in situations where existing writable mapped regions need to be
> +kept intact while preventing any future writes. For example, to share a
> +read-only memory buffer to other processes that only the sender can write to.
>  .\"
>  .SS File read/write hints
>  Write lifetime hints can be used to inform the kernel about the relative
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
