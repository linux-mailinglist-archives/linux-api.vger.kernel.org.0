Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E76F3B6C
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 23:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKGWcJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 17:32:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbfKGWcJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 17:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573165927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKIOzw39YTWyZ5qlTTzm//isaKLAzIIX1M3HJzcWPI0=;
        b=iTu5B1u3r1Kl3Fmn7uf1vx2OSPbmVDxCC9mrKraPR0ewrf+jQVq/HauLE8IUacmYhEKDeS
        juJqf8dRY54R3uJPY0T20uD6O0pv0pYFJr/NWWWbMEKnAXZJknhnd+bi67xF8/FVviqLXZ
        CtHGpKthX6dUqsOBvk/6iZHwKFq4SmQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-L_kr5h3OMaqqGxGfwoS0dg-1; Thu, 07 Nov 2019 17:32:04 -0500
Received: by mail-qk1-f198.google.com with SMTP id 6so4070554qkc.4
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 14:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A6VPnYHHRG17+zqS0tqCfOSRspRCWxbi4PanBqk6ajc=;
        b=W8FPywQypgUkwspmO8Q5Qn/jbuAT+fT+T6koT6yK4tc2EIU49MBwS+qUFYiZPV1Kkk
         GD0y253HF5LQgpSwaKOh1PSJS25qit1ZfmL5phIHLRe+5fHLPbPWsHqIbx9WNyz82yyp
         nnRzjev79ceUtPthxMt/iF4JhQ4bttVKFjXBjH15UzE1isCy0RU+oErnKLVpqy3fKVl7
         nf+ZX9p71yuxIhkfvXE7IilEEaC1fDwyHxV6rGZE4EDKp2W4SzILda6+mYPJ3r8Omjdg
         j8M0YtnLhG8/Uv0mYO4uyYpe3P9fb7L355iSFVPWDUtdmXp0ujtoxy40O1F6+o9UzL0A
         gqZQ==
X-Gm-Message-State: APjAAAUFeR8khuYYIsmW286oVBJT4SyyYn8fs1KOAUdrydmePOwVeZYy
        SwYrTBb1+kppTvvApFAwlQH83uBjiPpUgJwMpXy3X0BmMQZPU25SL8azWzdcg3AjVkylGID7I/B
        Iuf/8SPf0WgtDqlX0uYVF
X-Received: by 2002:a0c:edb2:: with SMTP id h18mr6121590qvr.36.1573165924033;
        Thu, 07 Nov 2019 14:32:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8ZAtea1Fb+no9ijy/FoPlfgh3YYmHWTk0oie1PlfPx2tTjPyaCLcwN1DY6U8fDf7Ollfs0A==
X-Received: by 2002:a0c:edb2:: with SMTP id h18mr6121547qvr.36.1573165923638;
        Thu, 07 Nov 2019 14:32:03 -0800 (PST)
Received: from [192.168.1.4] (135-23-175-75.cpe.pppoe.ca. [135.23.175.75])
        by smtp.gmail.com with ESMTPSA id s21sm2335458qtc.12.2019.11.07.14.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 14:32:02 -0800 (PST)
Subject: Re: Continuing the UAPI split
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elichai Turkel <elichai.turkel@gmail.com>, nd <nd@arm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
 <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
 <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
 <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
 <facb4d0d-4e20-41f0-4c01-b210c677c24c@arm.com>
 <086ffddf-553f-453d-a046-4d5e6abead21@redhat.com>
 <875zjvo2be.fsf@mid.deneb.enyo.de>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <70a264b5-427f-fa6e-7f70-768724202d14@redhat.com>
Date:   Thu, 7 Nov 2019 17:32:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875zjvo2be.fsf@mid.deneb.enyo.de>
Content-Language: en-US
X-MC-Unique: L_kr5h3OMaqqGxGfwoS0dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/7/19 3:32 PM, Florian Weimer wrote:
> * Carlos O'Donell:
>=20
>> On 11/7/19 11:21 AM, Szabolcs Nagy wrote:
>>>> Or just giving up and telling users they can't just directly include
>>>> both libc headers and kernel headers?
>>>
>>> including both libc and linux headers is fragile and
>>> will break differently across the different linux
>>> libc implementations.
>>
>> We saw this all the time working in embedded.
>=20
> Do you mean you saw problems while you working in the embedded space?
=20
Yes, embedded Linux to be specific.

There is a strong coupling between the kernel version and the toolchain
version, specifically because the strategies we take to solve these
problems end up being brittle in this regard.

Too new a kernel and you get new header problems not solved by your
old libc. Too new a libc and the kernel doesn't have the header
coordination fixes required for the newer software that needed the
newer libc.

Does that clarify my point?

--=20
Cheers,
Carlos.

