Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78911044B6
	for <lists+linux-api@lfdr.de>; Wed, 20 Nov 2019 20:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKTT5j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Nov 2019 14:57:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35137 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfKTT5h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Nov 2019 14:57:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so535839ljg.2;
        Wed, 20 Nov 2019 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=kDQsdzKDzS/Oy819XkLIM9indqOFd/F+CRs0/CEl7oc=;
        b=AT2JuyiUnQWnrJ2ot/c7KQVwbQLWTfYonw9cSis/NRviXRYVTZGAv+Krvj2zYSp39Y
         wIf/zoXuQMv1o5i4/1OXhXK1zcyFm8GbxxwHJLmcJK6tUe/EWXOleJXW/jyZQ6zhdjHy
         lcnE+T30LrMvX13OCvaNYiKQi9MAE96xiZ61miv8ZzrChywbvHqX/vL81rnSPqVO6TNE
         lZUS3+C0qnb/6YnOg/HKlaXsI7JthbBn9sg4us+zAZhEGkXO0FNnhKkafzZP11+xzb3P
         IVqioVvK29rbDwat84saZnfx7k7fGmPv1g4VxpIok9zEkZCfC4wQFgB3DfAA0g8TUAZ+
         1IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=kDQsdzKDzS/Oy819XkLIM9indqOFd/F+CRs0/CEl7oc=;
        b=j8qWGbBernom8l8AeseTcIhf9qKKGaZBnRpylzIPU4lYqqI08hQB1sSH9k54hjoJoi
         pkLoKDadhVfmqOLW4i5KjGARHa9ZX69if8U6vy323cW3+Mm1jhbnJjSURz5+ZE8o1kFb
         j4gr5ObLvpuPDUgccMTqPWz96KGvRuQTaImUcUMRygimHpZ7jBA2fVMHjtEq4svsAW+W
         d6MbZtIdvS2CcMQ2O64t0MlhY33dQkrLKBaaFkRuBT3JpVJW8PXziQaGEUi9VLTkrJLV
         oHFxRpgq30HtldKvPnUSBapkzVv+f9vPNzT5jvsvdTTYRyj0Bh5IzuAUQxwxxk36mEw2
         UCyA==
X-Gm-Message-State: APjAAAV5HPTTGacwzdkGTuyNVTzA6AbHrOcRjPkA7ZmkGQZyp4LmAivR
        26wWeHT9DL01LLqyDRlX/gs=
X-Google-Smtp-Source: APXvYqyX1lGdw+mT48rV3YFa9rVR9jY+RqHueK/++NbaKtnD2HIortYY3/wflsxO67CDfUfeHFxoUA==
X-Received: by 2002:a2e:81c6:: with SMTP id s6mr4328315ljg.61.1574279854771;
        Wed, 20 Nov 2019 11:57:34 -0800 (PST)
Received: from ?IPv6:2a02:17d0:4a6:5700:d63d:7eff:fed9:a39? ([2a02:17d0:4a6:5700:d63d:7eff:fed9:a39])
        by smtp.googlemail.com with ESMTPSA id p24sm15362lfc.96.2019.11.20.11.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 11:57:33 -0800 (PST)
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de>
 <19681012.svDddlc5pN@positron.chronox.de>
 <20191120132918.GA2892197@kroah.com> <1695782.oZ5Vf4nH9s@positron.chronox.de>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <59be1ccc-8838-e518-fbef-8cc7ca2f70d6@gmail.com>
Date:   Thu, 21 Nov 2019 00:57:31 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1695782.oZ5Vf4nH9s@positron.chronox.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050205030400080504000700"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050205030400080504000700
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

21.11.2019 00:51, Stephan M=C3=BCller =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Am Mittwoch, 20. November 2019, 14:29:18 CET schrieb Greg Kroah-Hartman=
:
>=20
> Hi Greg,
>=20
>> On Wed, Nov 20, 2019 at 09:58:35AM +0100, Stephan M=C3=BCller wrote:
>>> Am Dienstag, 19. November 2019, 13:41:50 CET schrieb Greg Kroah-Hartm=
an:
>>>
>>> Hi Greg,
>>>
>>>> On Tue, Nov 19, 2019 at 02:07:40AM -0800, Andy Lutomirski wrote:
>>>>>> As this would introduce a new device file now, is there a special
>>>>>> process that I need to follow or do I need to copy? Which
>>>>>> major/minor
>>>>>> number should I use?
>>>>>>
>>>>>> Looking into static const struct memdev devlist[] I see
>>>>>>
>>>>>>           [8] =3D { "random", 0666, &random_fops, 0 },
>>>>>>           [9] =3D { "urandom", 0666, &urandom_fops, 0 },
>>>>>>
>>>>>> Shall a true_random be added here with [10]?
>>>>>
>>>>> I am not at all an expert on chardevs, but this sounds generally
>>>>> reasonable.  gregkh is probably the real authority here.
>>>>
>>>> [10] is the aio char device node, so you better not try to overlap i=
t or
>>>> bad things will happen :(
>>>
>>> Thanks for your insights.
>>>
>>> Which device minor number could we use?
>>
>> Get your own dynamic one by using a misc device if you _REALLY_ want t=
o
>> add yet-another-char-node-for-random-data.
>>
>> But I would have thought that we all realize that this is not the way =
to
>> do things.  Let's not have "random", "urandom", and "true_random" be
>> something we want to totally confuse userspace with, that way is insan=
e.
>>
>> Please just make the existing userspace api "just work", don't add to
>> the mess.
>=20
> Thank you, I think we should follow that advise.
>=20
> With that and considering Alexander's rightful remark we have a challen=
ge. So,
> changing the syscall may not be the right way unless we find a way to r=
estrict
> the permissions somehow (capability? LSM? None of that seems to be a go=
od
> fit).
>=20
> What about providing a /sys file? I.e. adding a file that:
>=20
> a) has permissions 440 per default and maybe the ownership of root:root=

>=20
> b) allow user space to perform a chown/chgrp
>=20
> c) only supports reading of data from user space
>=20
> But then, how could we provide a common interface for the existing rand=
om.c
> and the LRNG?
>=20
> Or should we use a proc file for that? If yes, I guess it should not be=
 a
> sysctl, but a "regular" proc file that should allow a chown(2) operatio=
n. On
> the other hand, is proc the right place to provide a user space interfa=
ce for
> exporting data to user?
>=20
> Thanks a lot.
>=20
> Ciao
> Stephan
>=20
>=20

I'd say that a sys or proc file is worse than a device node, because the =

wanted semantics are exactly those of a device node. Besides, a chown of =

a sysfs file is something not friendly to containers. We may need=20
different uids in different containers to be able to access true random=20
data.

--=20
Alexander E. Patrakov


--------------ms050205030400080504000700
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Криптографическая подпись S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C5wwggVNMIIENaADAgECAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3DQEBCwUAMIGCMQsw
CQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoM
GkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBB
dXRoZW50aWNhdGlvbiBDQSBHMTAeFw0xOTA2MDYwODAxMzVaFw0yMDA2MDYwODAxMzVaMB0x
GzAZBgNVBAMMEnBhdHJha292QGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAOA0sb1ubDnIK32rbgW3BnjBcx1pYuEFOCU6aPVJ2gU+wtKJgAo9IdVUXG6kC1fF
hXjIcZHOgbEqzFjHK1yXlHIUWEv+N8KdmBDOK1UdKQj58d9A4hnH62iEiwQsOR5YT1UyHX4A
pfMjsBja7254cixR4jOPzfA4YUD6JTTPioyjDwuYQlhweVyXziKswLtGWfKeDcm3fOlKYxGy
hxjWJRamGTreNBVC9uMkF4DHszpUm07agR2U4mnWy7FsjBuRJ++iX0SvuxKWf19HQWgmgIys
jBVrArhVzgjOOnbvlklW849wIARF4Y0WAf91DsqPtuR8hu7+9KIVj2qk9BeNXXUCAwEAAaOC
AiEwggIdMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUfmD8+GynPT3XrpOheQKPs3QpO/Uw
SwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vY2FjZXJ0LmFjdGFsaXMuaXQv
Y2VydHMvYWN0YWxpcy1hdXRjbGlnMTAdBgNVHREEFjAUgRJwYXRyYWtvdkBnbWFpbC5jb20w
RwYDVR0gBEAwPjA8BgYrgR8BGAEwMjAwBggrBgEFBQcCARYkaHR0cHM6Ly93d3cuYWN0YWxp
cy5pdC9hcmVhLWRvd25sb2FkMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDCB6AYD
VR0fBIHgMIHdMIGboIGYoIGVhoGSbGRhcDovL2xkYXAwNS5hY3RhbGlzLml0L2NuJTNkQWN0
YWxpcyUyMENsaWVudCUyMEF1dGhlbnRpY2F0aW9uJTIwQ0ElMjBHMSxvJTNkQWN0YWxpcyUy
MFMucC5BLi8wMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDti
aW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSENM
LUcxL2dldExhc3RDUkwwHQYDVR0OBBYEFEhX9pz3jwI3+erfsAVB2b4xSsM8MA4GA1UdDwEB
/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAQEAVbKht9PGiUsUaqiyzJb6blSMNaLwopQr3AsI
FvthyqnSqxmSNYDeZsQYPgBnXvMCvHCn07pm1b96Y3XstBt2FWb9dpDr7y+ec3vxFHb3lKGb
3WREB1kEATnBu2++dPcILG58gdzgYde3RAJC3/OyOZhDqKwQA5CnXTHigTzw75iezdLne5pU
MjEQoxdqC+sgbrAueaEpMmRsGSKzgIX8eQ3DWwyIL56fYPJP3u4WZmBUKTFhhUWowG62QLtt
ZjkiX/j+vjcSRd2app8lYDwQRornZAqrDxy+c4qQJ5FN234p36opwespDCwLN3Z6wPzLvzS+
jAlmV3DF2xuZGMoebzCCBkcwggQvoAMCAQICCCzUitOxHg+JMA0GCSqGSIb3DQEBCwUAMGsx
CzAJBgNVBAYTAklUMQ4wDAYDVQQHDAVNaWxhbjEjMCEGA1UECgwaQWN0YWxpcyBTLnAuQS4v
MDMzNTg1MjA5NjcxJzAlBgNVBAMMHkFjdGFsaXMgQXV0aGVudGljYXRpb24gUm9vdCBDQTAe
Fw0xNTA1MTQwNzE0MTVaFw0zMDA1MTQwNzE0MTVaMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UE
CAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAz
MzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMD8wYlW2Yji9ARlv80JNasoKTD+
DMr3J6scEe6GPV3k9WxEtgxXM5WX3oiKjS2p25Mqk8cnV2fpMaEvdO9alrGes0vqcUqly7Pk
U753RGlseYXR2XCjVhs4cuRYjuBmbxpRSJxRImmPnThKY41r0nl6b3A6Z2MOjPQF7h6OCYYw
tz/ziv/+UBV587U2uIlOukaS7Xjk4ArYkQsGTSsfBBXqqn06WL3xG+B/dRO5/mOtY5tHdhPH
ydsBk2kksI3PJ0yNgKV7o6HM7pG9pB6sGhj96uVLnnVnJ0WXOuV1ISv2eit9ir60LjT99hf+
TMZLxA5yaVJ57fYjBMbxM599cw0CAwEAAaOCAdUwggHRMEEGCCsGAQUFBwEBBDUwMzAxBggr
BgEFBQcwAYYlaHR0cDovL29jc3AwNS5hY3RhbGlzLml0L1ZBL0FVVEgtUk9PVDAdBgNVHQ4E
FgQUfmD8+GynPT3XrpOheQKPs3QpO/UwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRS
2Ig6yJ94Zu2J83s4cJTJAgI20DBFBgNVHSAEPjA8MDoGBFUdIAAwMjAwBggrBgEFBQcCARYk
aHR0cHM6Ly93d3cuYWN0YWxpcy5pdC9hcmVhLWRvd25sb2FkMIHjBgNVHR8EgdswgdgwgZag
gZOggZCGgY1sZGFwOi8vbGRhcDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVu
dGljYXRpb24lMjBSb290JTIwQ0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2
NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6
Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwDgYD
VR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQBNk87VJL5BG0oWWHNfZYny2Xo+WIy8
y8QP5VsWZ7LBS6Qz8kn8zJp3c9xdOkudZbcA3vm5U8HKXc1JdzNmpSh92zq/OeZLvUa+rnnc
mvhxkFE9Doag6NitggBPZwXHwDcYn430/F8wqAt3LX/bsd6INVrhPFk3C2SoAjLjUQZibXvQ
uFINMN4l6j86vCrkUaGzSqnXT45NxIivkAPhBQgpGtcTi4f+3DxkyTDbWtf9LuaC4l2jgB3g
C7f56nmdpGfpYsyvKE7+Ip+WryH93pWt6C+r68KU3Gu02cU1/dHvNOXWUDeKkVT3T26wZVrT
aMx+0nS3i63KDfJdhFzutfdBgCWHcp03NhOhMqy1RnAylF/dVZgkka6hKaWe1tOU21kS4uvs
D4wM5k6tl0pin2o6u47kyoJJMOxRSQcosWtDXUmaLHUG91ZC6hvBDmDmpmS6h/r+7mtPrpYO
xTr4hW3me2EfXkTvNTvBQtbi4LrZchg9vhi44EJ7L53g7GzQFn5KK8vqqgMb1c1+T0mkKdqS
edgGiB9TDdYtv4HkUj/N00TKxZMLiDMw4V8ShUL6bKTXNfb3E68s47cD+MatFjUuGFj0uFPv
ZlvlNAoJ7IMfXzIiTWy35X+akm+d49wBh54yv6icz2t/cBU1y1weuPBd8NUH/Ue3mXk0SXwk
GP3yVDGCA/YwggPyAgEBMIGXMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8w
DQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSww
KgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4r
qg9tGyNesDANBglghkgBZQMEAgEFAKCCAi8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTkxMTIwMTk1NzMxWjAvBgkqhkiG9w0BCQQxIgQgXySl0QC1e5r3
QpLtFj3Dad5qR+TfvxLJtpdxy1A5VRcwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBAB2N1K0BxuL6qEy1q7Kbv+cs0RyRvaUigIa+zeOkmbyeX2NOFw5rlPnkfuSK
xmMlaz1uzkiNEPih+g2BtdyrWa9v6EE42H6JrqWciggAjvSg2wyu3cVmAd4F9nMqKCWZYunK
ieS43phG2C6Q1vpYJPx5x+2D6/rixW1C7X/IqDI6FGt8v1by/H9QHpGjox2RPIRCSveUYocK
SGjIPJg17RcVDM6KnIzRmYE3nrIWZqS43mT/7QrxMlsTaYddlXaRLrqjN9qUBSDrhHg1brV7
GlwLQ3xVP82z2u9OwMRYqLI5DGVwXc2ObLX9MTO0pTokzrsFCPtDigkSxQIxkDUfpw4AAAAA
AAA=
--------------ms050205030400080504000700--
