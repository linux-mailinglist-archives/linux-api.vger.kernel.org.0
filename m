Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20141156416
	for <lists+linux-api@lfdr.de>; Sat,  8 Feb 2020 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBHL6g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 8 Feb 2020 06:58:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41326 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHL6g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 8 Feb 2020 06:58:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so1920362wrw.8;
        Sat, 08 Feb 2020 03:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RA+DcKLOH04eZAE0VKEwzjEXVfayOhXH9+LcEXdqUQ=;
        b=X+mp1dsiHIK3afypH19H3MfHmvRt9uwp9dXzgSorSUMipG1Jdi/A4k40tenq0Lj8AP
         VyKJ4fRmD0fIP/ge3FXVYNi/+OH2hhB94KqLGAGQyqQkNaZwbauJxeH2lpmvJYnufKdg
         mFxktZ5l2S1Smm93d8sTKdirV3vnj4GsB0uwHokchyh0J06e688q56faDl9HRJAO4qHp
         4EzQgZMxl0Ld3QzQin8u/17pArvTFo9KRR1SFsGy4H1tHAAGD1bqEqJ+ATWDmCZBSmiT
         ZMGH2yLAZ1AnFv++Z6YUpc/ljSdpJzTw3eC/zZadrBTtBKLJBxTwbHr2KQBUi0Fwq7MQ
         H0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RA+DcKLOH04eZAE0VKEwzjEXVfayOhXH9+LcEXdqUQ=;
        b=bbxS/yItaVqOE0JzrGoK1zqyAP9uLQk5o+PgS9S7BXaZQd7RrlIVNJC/rPwhdTj4fD
         dqjJKv0THh3E8AfhQuatdYxVXmtHWMvWTAARESqnoCm+XKIRGBjbR4Dv7bKhMK3gHubm
         NBUSr/jJw1Ll5ErlrMD8scSFm5eTRkS8XXzfPZtwRg+MAntzqtza0hBglW9v1m62zssU
         UdqkC4ttcFMr76JhW1BXLUHs8ROmaMiBlsiVx6uZ5QkHQWPJMUKi5yO9CBN0erkevPzF
         9WF/FehlGqwRq0ppDqnoK4I+fq2nS8owKQ+Yzmj3ZLY3lgDiSstlOlphGvzrtZIPkcpU
         f49g==
X-Gm-Message-State: APjAAAXo8Xtq/t6NjvUcGWgwDY5RH3H7+HuZq7SdJgTanZUkhWz+dR2B
        N17U+wDCPci6xvwK9DVCVBw=
X-Google-Smtp-Source: APXvYqxZbYtfPLLgiQoUCT62Ix94MBBNGuSv8who7NIbvQSyTmCeN1RvJyFVBeyLSh+8O1ajn52N3g==
X-Received: by 2002:adf:f507:: with SMTP id q7mr5094539wro.384.1581163114265;
        Sat, 08 Feb 2020 03:58:34 -0800 (PST)
Received: from ?IPv6:2001:a61:251f:d701:c8c9:6ecf:205c:abb7? ([2001:a61:251f:d701:c8c9:6ecf:205c:abb7])
        by smtp.gmail.com with ESMTPSA id h13sm8318098wrw.54.2020.02.08.03.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 03:58:33 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -manpage 2/2] memfd_create.2: Update manpage with new
 memfd F_SEAL_FUTURE_WRITE seal
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
References: <20190314214844.207430-1-joel@joelfernandes.org>
 <20190314214844.207430-3-joel@joelfernandes.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3349d0f2-6ea0-4e3a-1d9b-5a105edc34c8@gmail.com>
Date:   Sat, 8 Feb 2020 12:58:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20190314214844.207430-3-joel@joelfernandes.org>
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

Thanks! Patch applied

Cheers,

Michael



> ---
>  man2/memfd_create.2 | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/memfd_create.2 b/man2/memfd_create.2
> index 15b1362f5525..3b7f032407ed 100644
> --- a/man2/memfd_create.2
> +++ b/man2/memfd_create.2
> @@ -280,7 +280,15 @@ in order to restrict further modifications on the file.
>  (If placing the seal
>  .BR F_SEAL_WRITE ,
>  then it will be necessary to first unmap the shared writable mapping
> -created in the previous step.)
> +created in the previous step. Otherwise, behavior similar to
> +.BR F_SEAL_WRITE
> +can be achieved, by using
> +.BR F_SEAL_FUTURE_WRITE
> +which will prevent future writes via
> +.BR mmap (2)
> +and
> +.BR write (2)
> +from succeeding, while keeping existing shared writable mappings).
>  .IP 4.
>  A second process obtains a file descriptor for the
>  .BR tmpfs (5)
> @@ -425,6 +433,7 @@ main(int argc, char *argv[])
>          fprintf(stderr, "\et\etg \- F_SEAL_GROW\en");
>          fprintf(stderr, "\et\ets \- F_SEAL_SHRINK\en");
>          fprintf(stderr, "\et\etw \- F_SEAL_WRITE\en");
> +        fprintf(stderr, "\et\etW \- F_SEAL_FUTURE_WRITE\en");
>          fprintf(stderr, "\et\etS \- F_SEAL_SEAL\en");
>          exit(EXIT_FAILURE);
>      }
> @@ -463,6 +472,8 @@ main(int argc, char *argv[])
>              seals |= F_SEAL_SHRINK;
>          if (strchr(seals_arg, \(aqw\(aq) != NULL)
>              seals |= F_SEAL_WRITE;
> +        if (strchr(seals_arg, \(aqW\(aq) != NULL)
> +            seals |= F_SEAL_FUTURE_WRITE;
>          if (strchr(seals_arg, \(aqS\(aq) != NULL)
>              seals |= F_SEAL_SEAL;
>  
> @@ -518,6 +529,8 @@ main(int argc, char *argv[])
>          printf(" GROW");
>      if (seals & F_SEAL_WRITE)
>          printf(" WRITE");
> +    if (seals & F_SEAL_FUTURE_WRITE)
> +        printf(" FUTURE_WRITE");
>      if (seals & F_SEAL_SHRINK)
>          printf(" SHRINK");
>      printf("\en");
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
