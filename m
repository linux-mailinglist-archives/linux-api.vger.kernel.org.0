Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575DB3046C9
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbhAZRUK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 12:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390819AbhAZJJS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Jan 2021 04:09:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF60C06174A
        for <linux-api@vger.kernel.org>; Tue, 26 Jan 2021 01:08:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so15596449wrx.4
        for <linux-api@vger.kernel.org>; Tue, 26 Jan 2021 01:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qQxlWty85dvfGFlbA5g1keGbJcIY/a/+CTU5RPzQHpY=;
        b=YlGolM/fDumf4LdRNZGoOlfchWA4g12BQ6lVsA0KoxqibrBvbt7gh9Ir46FcPS1Lbm
         zJm2PWRg42z0/XaqfzZtYmJ91c2XO37QZHMgAln9uf/1LAzkqQMPaHJS1836UDooRxl3
         AmVmeTnoVX0Nc2nwGQ8A3E2P3zAf9AzMNL22Y91XOL0SXi6u6L+RG2i2o6W5TJmt1HZr
         vlYYmiEGlnnMYy+A0u5S+QS/1FBf4BILqK0Uv3Bh+rNZgKPgN7rR1wptPETLdm7rFSm/
         k9JApQonQ6m0lwSL+uLt0V5vcInxMutwpJz/uj6ZaHgialbqFiaXlZ/5ily8MmoiHh0K
         JQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQxlWty85dvfGFlbA5g1keGbJcIY/a/+CTU5RPzQHpY=;
        b=pSoUdUPeP8foUZfx8tcmoWQ/vlHidLI+miUnrlxaOu1ik9QJyDznkyravrDC2bpOse
         lsIRHHybL2PWnfbqBMZ4Aj3lyJPaPTJfSlROVsW0SFZPGVCGBKWgoI4eFAglx9cODE42
         2JK3vfjhLlh7Iq/TbOxwVYez2KtoDkhDnNgzlUlxzedQzC/XR8onzwSPAhnvpV3tr2vD
         DEwfPBY6UaK4yz0zyu1NRRWJB3UNFt2zF3Kx7v9WimHkFzx8RZOuCZ2hXCJI1nYN0yq0
         mrw77pTvl1HsnVzewfm7IXiRXzPp78y41+Ylri2N2E26yMKUPHYAnW73eVegeiIS56wu
         JYrA==
X-Gm-Message-State: AOAM530YsakJfh6q/JHyV+ojfcx7AGrlvElT5SgiLHjO2WkRTf05fhI5
        5tHFdm4qYnh6Rl7+cLOzaFQRIbBbFcf0Fg==
X-Google-Smtp-Source: ABdhPJzlehwChFhg6kzuG7riJ8kiJZF8hNS9m8rUH/O+l+37pvC8oDm6hOIF/vAjkuDamc9wZKRvgQ==
X-Received: by 2002:a5d:6509:: with SMTP id x9mr4984029wru.229.1611652108362;
        Tue, 26 Jan 2021 01:08:28 -0800 (PST)
Received: from [10.8.0.134] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id a62sm2472818wmf.7.2021.01.26.01.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 01:08:27 -0800 (PST)
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Coreutils <coreutils@gnu.org>
Cc:     Fabrice BAUZAC <noon@mykolab.com>, Otto Moerbeek <otto@drijf.net>,
        Alex Henrie <alexhenrie24@gmail.com>, juli@clockworksquid.com,
        Jeffrey Walton <noloader@gmail.com>,
        freebsd-hackers@freebsd.org,
        William Ahern <william@25thandclement.com>,
        Roman Czyborra <roman@czyborra.com>, oshogbo@freebsd.org,
        tech@openbsd.org, Christian Groessler <chris@groessler.org>,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>, ed@nuxi.nl,
        Eric Pruitt <eric.pruitt@gmail.com>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com>
 <YA2ztHUATu1gOxoV@clue.drijf.net>
 <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
 <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
 <d0d1697b-7851-9078-289e-02ef76f3303a@gmail.com>
Message-ID: <834af55b-0935-ec2f-784c-3874cd05ba75@gmail.com>
Date:   Tue, 26 Jan 2021 10:08:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <d0d1697b-7851-9078-289e-02ef76f3303a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Berny,

On 1/25/21 12:33 PM, Alejandro Colomar (man-pages) wrote:
> On 1/25/21 5:03 AM, Bernhard Voelker wrote:
>> On 1/24/21 9:01 PM, Alex Henrie wrote:
>>> I am definitely interested. Bernhard Voelker seemed to express
>>> interest as well, conditional on -q being added to POSIX first.[1]
>>
>> Just to clarify: I'm not as enthusiastic to add that option as it
>> may have sounded.
>>
>> Let me put it like this: if -q once gets standardized by POSIX,
>> then we'd take it over in the GNU tee implementation.
>>
>> Let me summarize so far:
>> The suggestion is to solve the problem to save some data coming from
>> a pipe as a different user.
>> There are at least those known solutions:
>>    - use > or >> redirection.
>>    - use dd(1)
>>
>> I have the impression that a home for this feature was searched
>> in any tool, and as tee(1) already knew how to write to a file,
>> had the "append" feature, and is often used in pipes, it was
>> tempting to add it there.
>>
>> But looking deeper, --quiet doesn't seem to fit well into 'tee'.
>> It even contradicts to the title line in the man page:
>>    "read from standard input and write to standard output and files"
>>
>> An off-tech argument: ask a local plumber if he'd would ever use
>> a tee piece instead of a pipe end piece.  I guess he would only
>> if he wouldn't have anything else at hand.
> 
> I never knew what 'tee' meant.  That makes sense now.
> 
>>
>> A word to the proposed patch: what should happen, if the user does
>> not give a file?
>>    A | B | tee -q
>> The patch just silently ignored that situation which feels wrong.
>>
>> Therefore, adding a feature which does not really fit is wrong, and
>> contradicts the one-tool-for-one-purpose UNIX philosophy.
>>
> 
> Agreed.
> 
>> OTOH I understand that there's a little gap in the tool landscape.
>> Astonishingly, there doesn't seem to exist a trivial tool to redirect
>> from standard input (or any other input file descriptor) to a file.
>> I wrote such a little tool in the attached:
>>
>>    $ src/sink --help
>>    Usage: src/sink [OPTION]... FILE
>>    Copy input stream to FILE.
>>
>>    Mandatory arguments to long options are mandatory for short options 
>> too.
>>
>>      -a, --append              append to the given FILE, do not overwrite
>>      -c, --create              ensure to create FILE, error if exists
>>      -i, --input-stream=FD     read from stream FD instead of standard 
>> input


On second thought, this program does two things: read any FD, and write 
to file.  I think it should be limited to writing to a file from stdin.

If you think there's a need for reading FDs other than 0, you might as 
well want to pipe that information you're reading from them to filter it 
with another tool, and this program doesn't allow you to do that, as 
it's a sink.

So, I would remove '-i, --input-stream'.  (And if you think it's 
missing, maybe write a program to read from any FD and write to stdout.)

Regards,

Alex


>>
>>    The default input stream number FD is 0, representing the standard 
>> input.
>>
>> This allows not only to copy data from standard input, but from any
>> file descriptor open for reading.  It also allows control over
>> how the output file will be opened (e.g. with O_CREAT|E_EXCL).
>>
>> The OPs case would look like:
>>
>>    echo 'foo' | sudo sink /etc/foo
>> or
>>    echo 'foo' | sudo sink -a /etc/foo  # append.
>> or
>>    echo 'foo' | sudo sink -c /etc/foo  # ensure creation of the file.
>>
>> I'm not sure if this will ever be considered for inclusion -
>> I just did it "for fun". ;-)
> 
> Tested-by: Alejandro Colomar <alx.manpages@gmail.com>
> Reviewed-by: Alejandro Colomar <alx.manpages@gmail.com>
> 
> Much better than my patch.  :-)
> 
>>
>> Have a nice day,
>> Berny
>>
> 
> Have a nice day!
> Alex
> 
> 
> -- 
> Alejandro Colomar
> Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
> http://www.alejandro-colomar.es/


-- 
--
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
