Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75B919C0EF
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 14:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgDBMQO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 08:16:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgDBMQN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 08:16:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so3874839wrw.12;
        Thu, 02 Apr 2020 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3cYQDBf7WbFceFTnjpJ8bNq7bCP83ezZSeqnAeRla1Y=;
        b=t6I/51ruTG1VSTBARVBPO1eeVMQfpX3ouNPdQXn0poUld+hANfcsxW1j+j1Y27JH73
         aBzRxfwV8/6AINBEAVbq1imHeTwytsohSRhZjW2NURSbHaXO0yUrTVAE/RZJjITMAAdR
         1wMh/4av0W2s2PVZnNnurtYiAx1gFD+n6/BE7uhBB9o1dxFCIGGRgkIa7sSH+/gUgjW+
         MQBNy0ujg+dLYAlIgySgvGkhW4607BRJqh/R9IneMHEFsobpofDZrK3qQM2BhodeNM3N
         syoshDM2om+8e5zqjOLK37J5c5GLUj6aGGVdjPXb+Bg1x+viOXvQG+FEtbLAyhmWS3xf
         37cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cYQDBf7WbFceFTnjpJ8bNq7bCP83ezZSeqnAeRla1Y=;
        b=kXMRzajH98mTs5JU0dFJCoC2HOJjjLukUx6uyrd2bTO4WOE/ZaafDTg+25ENnXiSdW
         m5absDUZu16VIqM6CDE6eiGOqovbXqVmPmBlZwQihG2vOBzKlgcM7//PPhqokvAeDE2T
         m/k+j7feySOYAO24UOqU/JXDb8ypmn9yL6yBDOpBlRJNGmHVMfWpds+J4uk3sf8E62vp
         tQfi7fXfJXYUzHrNXCWcItFtn7eTDFCifkGVbcN/UMAS3Bnh0Wgh4fhAB83U+yGvjgYa
         q7yLCed277P7q3vJAzdA0IqItgZ6BikuqKPRW97Hi0VYw8wAHJPUn1/4XBlbCnWgxC5T
         afvQ==
X-Gm-Message-State: AGi0PuY4dPjGWzIz+c3Iwzd08q6wF4z9fkS/mGCjOeQfuiZZw2fQjXBi
        eGrDD8HQHZAW6mfehNZw2Bk=
X-Google-Smtp-Source: APiQypKzDVQBtqcs6ycj2jQwxarbQVBHULaIqFw+bLg2TCUEvCZLZxfecYQgNiqZ+gQhsij2QnRXNg==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr3168573wru.159.1585829771472;
        Thu, 02 Apr 2020 05:16:11 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id h5sm7255190wro.83.2020.04.02.05.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:16:11 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>, linux-api@vger.kernel.org,
        david@fromorbit.com, mhocko@suse.com, masato.suzuki@wdc.com,
        damien.lemoal@wdc.com, darrick.wong@oracle.com,
        linux-man@vger.kernel.org
References: <20200402020850.7218-1-mchristi@redhat.com>
 <9eab1b92-6a44-616a-44b2-f1ee6475f6f0@acm.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <5f2bf1c2-4e3e-2472-5035-a6842901b8c8@gmail.com>
Date:   Thu, 2 Apr 2020 14:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9eab1b92-6a44-616a-44b2-f1ee6475f6f0@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/2/20 5:46 AM, Bart Van Assche wrote:
> On 2020-04-01 19:08, Mike Christie wrote:
>> +.TP
>> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
>> +Return as the function result 1 if the caller is in the IO_FLUSHER state and
>> +0 if not.
> 
> Although I'm not at all a language expert, the word order at the start
> of the above sentence seems a bit weird to me?

Thanks for spotting that Bart. I changed the text to:

              If a user  process  is  involved  in  the  block  layer  or
              filesystem I/O path, and can allocate memory while process‐
              ing I/O requests it must set arg2 to 1.  This will put  the
              process  in  the  IO_FLUSHER state, which allows it special
              treatment to make progress when allocating memory.  If arg2
              is  0, the process will clear the IO_FLUSHER state, and the
              default behavior will be used.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
