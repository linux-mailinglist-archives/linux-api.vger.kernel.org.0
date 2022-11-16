Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08E62BDB3
	for <lists+linux-api@lfdr.de>; Wed, 16 Nov 2022 13:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKPMZc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Nov 2022 07:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiKPMZP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Nov 2022 07:25:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE71F35
        for <linux-api@vger.kernel.org>; Wed, 16 Nov 2022 04:21:10 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a27so10506956qtw.10
        for <linux-api@vger.kernel.org>; Wed, 16 Nov 2022 04:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aShTRDndkX9iTCzh0HBNsOxjA4JRM/MZEQqDRrnaQSQ=;
        b=nm4VwOrbdS60jP6mTCW33xJw/LdsnnhTA9Me9b2J2Kz7N0ykWuhZucF/Fqeg012c1/
         gVGGyTx0XjjVDyQChn8xCl2Y0znpdXKR/7znjZhOpySPAQLKgHr0uTEwiEWejlUcAOEA
         0TpB5KnmdIxJbxmzjUYhi8wT/7FQXqWWCihVXnokLF2WQEfSZBWtqeDIYtx4z1pjhzwe
         jhYxKd2fzURIQfoFXiXOLP2SdyTNcnXbBrEnNKYowMM9y1ssOf7iqyH97XmBjRCVomJ7
         Zej95iF0V3CjpiOaZleePjINhDYfHEfNiWDnHn+MNcGNAvtuDb1wysika+rrVtyFRm0b
         470w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aShTRDndkX9iTCzh0HBNsOxjA4JRM/MZEQqDRrnaQSQ=;
        b=hpK+683sKSKQK6xdFX0YbdkK73HMGgtPbpR2dPplphkaCx9Z42A93zD8y/oDHz7fP+
         GJ6B8OOG4zS5PNEP0827g7ff7eAMzDq0Y71jHrBf9FlrUitRYnKK79PoXQBtjTF9LX1X
         82Y08UZbA1i3f3s049OOSJNChn63Hd4tz1pA9diVO9MO01lpit7WIy3M+yby6M5X7QbB
         R5jnYEU/K8vsFAx/2lq/1KgS9lTQfwtc9flTI5QyDeVb1cf4M0kNyQIVtzlcP5AEn/Gf
         AogzsbVmXW7SJiJ9xAGpALrlzdVwSAz2H93pYZLwfPw0k92xg82SlQtJA53KZR2A0zvd
         D7ZA==
X-Gm-Message-State: ANoB5pnXUPI3Ua9XLvNmQNHxoHo15BZt0I7DoCLVdeX1nDLiUq+ZmY3Z
        O0Ntxtr2FBm6YyN8U2RhZwMP3SWV18rStKhqVO1xgnhtUFBQ0A==
X-Google-Smtp-Source: AA0mqf5HyT4xyd+8CbntN+CdULUj7ipoNPx/K4F2+ern1oEnYA0HM/aUQSMx5WeULUBmRM8qc9VxW3IfQI/WrfjArik=
X-Received: by 2002:ac8:7ca6:0:b0:3a5:9e38:9f4 with SMTP id
 z6-20020ac87ca6000000b003a59e3809f4mr20518901qtv.532.1668601269685; Wed, 16
 Nov 2022 04:21:09 -0800 (PST)
MIME-Version: 1.0
References: <CAEAAPHZrMDGsAnZM=GC0bu5WpGvXaDakJBq-WDkW06aDc7_68w@mail.gmail.com>
 <0a643215-03ce-4388-bd1a-301dcab87c41@mpi-sws.org>
In-Reply-To: <0a643215-03ce-4388-bd1a-301dcab87c41@mpi-sws.org>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Wed, 16 Nov 2022 13:20:58 +0100
Message-ID: <CAEAAPHZimy_V=1FMMn64n658Gg8gE=NZT6uDKgPm+2RVVSmE6A@mail.gmail.com>
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
To:     Michael Sammler <msammler@mpi-sws.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
        luto@amacapital.net, wad@chromium.org,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f9514e05ed9581dc"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--000000000000f9514e05ed9581dc
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 15, 2022 at 5:16 AM Michael Sammler <msammler@mpi-sws.org> wrote:
> > We're currently working on a feature in chromium that uses pkeys for
> > in-process isolation. Being able to use the pkey state in the seccomp
> > filter would be pretty useful for this. For example, it would allow
> > us to enforce that no code outside the isolated thread would ever
> > map/mprotect executable memory.
> > We can probably do something similar by adding instruction pointer
> > checks to the seccomp filter, but that feels quite hacky and this
> > feature would make a much nicer implementation.
> >
> > Are there any plans to make a version 2 of this patch?
>
> Thanks for your interest in this patch, but I am now working on other projects and currently don't plan to make a version 2 of this patch.

I'd be happy to take over writing a version 2 for this.

Kees and Dave, does this feature overall look good to you?

From the discussion, I think there are two proposed changes:
* use an architecture-generic interface as Ram Pai suggested (i.e. add
a read_pkey function)
* ensure to restore the pkru value or fetch it from the xsave buffer

--000000000000f9514e05ed9581dc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoQYJKoZIhvcNAQcCoIIPkjCCD44CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz7MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
sz7RGMFaSStMyOLBknrDoPcwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYI
KwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2Nh
L2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei
6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
bS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBADxHuVAXK0J/
tmhilgqykP+t0SazSxAHRxmPTTg6Cc7TFbQSRERTydbE3t5CaZoTYrhnRC+xTwmOeIyyab3fXoEG
2+vUQ1xZm5XfMjcw3EINopXAyFuB0Xjkuw4Ln9KUkGCZdiDZoGk3MVxE+IZHwoCgYkNvEuwPLq9M
cJq1kORO/au4JOBpdsJqzT/agKYjjiku/sz/Zk+hDSPdsea8wfuxnSUSpJrdEVKTQNSdoxWDrQXj
fn1Hzsf2x3Ewh+aOMcczShA7gA7syqQ50rolQFxkaB4ljQaCUzR6vYCZi7L3DA5G6MiAlJcSoq4A
xEDwfbryTuo1QZP+43heleunvWQxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENB
IDIwMjACEAHaNzji1wowJ2QV6D96JKMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IEfWQxYk6H30Oqz/MwyWv1UDPCKR6/HhhgFEt1NutVGcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMTExNjEyMjExMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAbydHCD1BvOlM3qJMD
JA0uygqvYQuvmLfn3fgVDAQ58Bibd8OXSaXnXWB4voeHEIXVk2lELdtDm7yClCtvVSayghvFRs81
NDSXXSebwEObskxt3yoyZb24fiDZLmBi/5GFeFvCqwTVO1h2N+JbfU6mwxWu+KbcaD8gJY2FoJzl
MCV+kGq9658BBorusMfizNEnLZur0zOnp3EqFr+uUJOvKOXdchdoJG5jGSVhREcnCAlcZREkZz5Z
m/D4jNQ/Mtg/uOWn4ucvvI6KSX9A2HLLkbt+68HARxGIJfrxT+4yNLo8PmPuw5OWmO7Ny26h/gHK
k9xGlsgYzaR7bSAMIMS9
--000000000000f9514e05ed9581dc--
