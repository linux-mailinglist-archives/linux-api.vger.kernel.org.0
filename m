Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54B6D1041
	for <lists+linux-api@lfdr.de>; Thu, 30 Mar 2023 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjC3UsG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Mar 2023 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC3UsF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Mar 2023 16:48:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4349CF
        for <linux-api@vger.kernel.org>; Thu, 30 Mar 2023 13:48:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id kq3so19274319plb.13
        for <linux-api@vger.kernel.org>; Thu, 30 Mar 2023 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112; t=1680209283;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHtvAvYwk+OhjqsGKAxXW2/s3HWisKfHheFojy3Y8AA=;
        b=NXQHFDieUokj38zhwMXA0WsZ5C6fHk62gQwULTmLxQ+BbUnH0DN29jlwITrPvNw5Oc
         4qck2RKfSDH4cKoVnj3UegXM6uDuDUOlQcjSYjN0CQQ39rl1PvVS509AqwJ6YUMphHli
         9mon9KkF1vjoNufI6NV7KWX0LZXkVoCKqzMwJdoyvoZ/wRcG6HE6bQtB2RceLQrDZbB3
         HEUKiPauZaght+a/i2LPEjQce46EpklQkiH3jT1mwxUVY4EzNmBwhOdVvekb4FcqpbE+
         F0CvyEWpmhdX0vF4CeYNP+5QfYPPVS7VFxhDj4CVLq6OoIYbt7PjE7wivSrfMIujEjsz
         JcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209283;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHtvAvYwk+OhjqsGKAxXW2/s3HWisKfHheFojy3Y8AA=;
        b=76qi+bD7G6hLGDzTJDZ+2Mf+XtBncBXgh7ThDroRZbkXV8AcVdLkrsBs7JmPrs5eRm
         gqJFHW2A+GnaWodjGmEbKihaZDx/+ob+CERStYPSnWa2m+ixDPKKxQ4749LoxEGNS22r
         stlaDWSOMLNHSBisUXUHhZ0yRy2QJ7JG48JUww6kYG3Y+zy+8nxas5XAcUbcbYekoShJ
         l96YIoIXVtxBAQcSTDHh4feb3ZEnEXOmt3Q283NV4aiqb2feUqbXxjPBkP0uYwiSawiL
         FSYRu0dyMG/dTXf03PL4G6cuKK1wIJGpERaRyOz49QoLvSGM8S6lMOKWFQLqs/pEjMvd
         mssQ==
X-Gm-Message-State: AAQBX9euVGTj0VlfYjMrQIivwtioelK/mZprZkPcG5MNMD9bvdJW1Kii
        IT404ge+QUxg17LLbe/sIM5DHw==
X-Google-Smtp-Source: AKy350a0n3fP0Bbyri4tgQbFuiaNErFnMu3T14WeVddrBfk3DsWEQjOH9H/wAtp1INVgBd/pDJ77Mw==
X-Received: by 2002:a17:902:e0c3:b0:1a2:92a4:f38c with SMTP id e3-20020a170902e0c300b001a292a4f38cmr1786983pla.13.1680209283634;
        Thu, 30 Mar 2023 13:48:03 -0700 (PDT)
Received: from smtpclient.apple ([216.9.110.9])
        by smtp.gmail.com with ESMTPSA id y1-20020a63de41000000b0050bc4ca9024sm223279pgi.65.2023.03.30.13.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 13:48:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [Bug 217238] New: Creating shared read-only map is denied after add write seal to a memfd
Date:   Thu, 30 Mar 2023 13:47:48 -0700
Message-Id: <6793EAB9-CF91-425A-B278-8A5D4415AD72@amacapital.net>
References: <a586f817-dbe4-4a44-b516-6086d9a89962@lucifer.local>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Herrmann <dh.herrmann@gmail.com>, yshuiv7@gmail.com,
        bugzilla-daemon@kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
In-Reply-To: <a586f817-dbe4-4a44-b516-6086d9a89962@lucifer.local>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
X-Mailer: iPhone Mail (20D67)
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Mar 30, 2023, at 12:25 PM, Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>=20
> =EF=BB=BFOn Sat, Mar 25, 2023 at 02:51:05PM +0000, Lorenzo Stoakes wrote:
>>> On Fri, Mar 24, 2023 at 01:36:46PM -0700, Andrew Morton wrote:
>>> (switched to email.  Please respond via emailed reply-to-all, not via th=
e
>>> bugzilla web interface).
>>>=20
>>>> On Fri, 24 Mar 2023 03:34:23 +0000 bugzilla-daemon@kernel.org wrote:
>>>=20
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D217238
>>>>=20
>>>>            Bug ID: 217238
>>>>           Summary: Creating shared read-only map is denied after add
>>>>                    write seal to a memfd
>>>>           Product: Memory Management
>>>>           Version: 2.5
>>>>    Kernel Version: 6.2.8
>>>>          Hardware: All
>>>>                OS: Linux
>>>>              Tree: Mainline
>>>>            Status: NEW
>>>>          Severity: normal
>>>>          Priority: P1
>>>>         Component: Other
>>>>          Assignee: akpm@linux-foundation.org
>>>>          Reporter: yshuiv7@gmail.com
>>>>        Regression: No
>>>>=20
>>>> Test case:
>>>>=20
>>>>    int main() {
>>>>      int fd =3D memfd_create("test", MFD_ALLOW_SEALING);
>>>>      write(fd, "test", 4);
>>>>      fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE);
>>>>=20
>>>>      void *ret =3D mmap(NULL, 4, PROT_READ, MAP_SHARED, fd, 0);
>>>>    }
>>>>=20
>>>> This fails with EPERM. This is in contradiction with what's described i=
n the
>>>> documentation of F_SEAL_WRITE.
>>>>=20
>>>> --
>>>> You may reply to this email to add a comment.
>>>>=20
>>>> You are receiving this mail because:
>>>> You are the assignee for the bug.
>>>=20
>>=20
>> This issue seems to be the result of the use of the memfd's shmem region'=
s
>> page cache object (struct address_space)'s i_mmap_writable field to denot=
e
>> whether it is write-sealed.
>>=20
>> The kernel assumes that a VM_SHARED mapping might become writable at any
>> time via mprotect(), therefore treats VM_SHARED mappings as if they were
>> writable as far as i_mmap_writable is concerned (this field's primary use=

>> is to determine whether, for architectures that require it, flushing must=

>> occur if this is set to avoid aliasing, see filemap_read() for example).
>>=20
>> In theory we could convert all such checks to VM_SHARED | VM_WRITE
>> (importantly including on fork) and then update mprotect() to check
>> mapping_map_writable() if a user tries to make unwritable memory
>> writable.
>>=20

Unless I=E2=80=99m missing something, we have VM_MAYWRITE for almost exactly=
 this purpose.  Can=E2=80=99t we just make a shared mapping with both of the=
se bits clear?

>> I suspect however there are reasons relating to locking that make it
>> unreasonable to try to do this, but I may be mistaken (others might have
>> some insight on this). I also see some complexity around this in the
>> security checks on marking shared writable mappings executable (e.g. in
>> mmap_violation_check()).
>>=20
>> In any case, it doesn't really make much sense to have a write-sealed
>> shared mapping, since you're essentially saying 'nothing _at all_ can wri=
te
>> to this' so it may as well be private. The semantics are unfortunate here=
,
>> the memory will still be shared read-only by MAP_PRIVATE mappings.
>>=20
>> A better choice here might be F_SEAL_FUTURE_WRITE (available from kernel
>>> =3D5.1) which does permit shared read-only mappings as this is explicitl=
y
>> checked for in seal_check_future_write() invoked from shmem_mmap().
>>=20
>> Regardless, I think the conclusion is that this is not a bug, but rather
>> that the documentation needs to be updated.
>>=20
>=20
> Adding docs people to cc list (sorry didn't think to do this in first
> reply).
